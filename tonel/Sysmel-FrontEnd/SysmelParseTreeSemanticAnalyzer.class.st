Class {
	#name : 'SysmelParseTreeSemanticAnalyzer',
	#superclass : 'SysmelParseTreeVisitor',
	#instVars : [
		'environment',
		'expectedType',
		'currentRegion'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> analyzeAST: ast withEnvironment: newEnvironment region: region [
	^ self analyzeAST: ast withEnvironment: newEnvironment region: region andExpectedType: nil
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> analyzeAST: ast withEnvironment: newEnvironment region: region andExpectedType: anExpectedType [
	| asg |
	environment := newEnvironment.
	expectedType := anExpectedType.
	currentRegion := region.
	asg := self visitNode: ast.
	^ SeaOfNodesCode new
		dataResult: asg;
		startingRegion: region;
		yourself
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> coerceNode: aNode into: targetType [
	targetType ifNil: [ ^ aNode ].
	aNode type = targetType ifTrue: [ ^ aNode ].
	targetType isVoid ifTrue: [ ^ aNode ].
	self error: ('{1} Cannot coerce from {2} into {3}' format: {
		aNode sourcePosition printString . aNode type printString. targetType printString
	})
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitAndEvaluateSymbolValue: node [
	| analyzedNode |
	analyzedNode := self visitNode: node.
	self assert: analyzedNode isLiteralValueGraphNode.
	self assert: analyzedNode value isSymbol.
	^ analyzedNode value
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitAndEvaluateType: aNode [
	^ self visitNode: aNode
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitApplicationNode: node [
	| analyzedFunctional analyzedFunctionalType analyzedArguments application isMacro macroArguments macroResult |
	analyzedFunctional := self visitNode: node functional.
	analyzedFunctionalType := analyzedFunctional type.
	isMacro := analyzedFunctional value isSysmelMacro.
	isMacro ifTrue: [
		| macro macroContext |
		macro := analyzedFunctional value.
		macroContext := MacroContext new
			sourcePosition: node sourcePosition;
			environment: environment;
			yourself.
		macroArguments := node arguments.
		macroResult := macro evaluateWithContext: macroContext andArguments: macroArguments.
		^ self visitNode: macroResult
	].
	
	analyzedArguments := node arguments collectWithIndex: [ :arg :index |
		self visitNode: arg
	].

	application := SoNApplicationGraphNode new
		sourcePosition: node sourcePosition;
		functional: analyzedFunctional;
		arguments: analyzedArguments;
		yourself.
	currentRegion addInstruction: application.
	^ application
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitAssignmentNode: node [
	| analyzedValue analyzedStore valueType alloca baseType coercedValue |
	analyzedValue := node value ifNotNil: [self visitNode: node value ] .
	node store isBindableNameNode ifTrue: [
		| bindableName name |
		bindableName := node store.
		name := self visitAndEvaluateSymbolValue: bindableName nameExpression.
		name ifNil: [ ^ analyzedValue ].
		valueType := analyzedValue type.
		bindableName typeExpression ifNotNil: [
			valueType = self visitAndEvaluateType: bindableName typeExpression
		].
		bindableName isMutable ifTrue: [
			alloca := SoNAllocaGraphNode new 
				sourcePosition: bindableName sourcePosition;
				valueType: valueType;
				type: (SysmelReferenceType withBaseType: valueType);
				yourself.
			currentRegion addInstruction: alloca.
			environment addSymbol: name valueBinding: alloca.				
		] ifFalse: [ 
			environment addSymbol: name valueBinding: analyzedValue.
		].
		^ analyzedValue
	].

	analyzedStore := self visitNode: node store.
	analyzedStore type isReferenceLikeType ifTrue: [
		baseType := analyzedStore type asDecayedSysmelType.
		coercedValue := self coerceNode: analyzedValue into: baseType.
		currentRegion addInstruction: (SoNStoreValueGraphNode new
			sourcePosition: node sourcePosition;
			pointer: analyzedStore;
			value: coercedValue).
		^ coercedValue
	].

	self error: 'Cannot perform this assignment.'
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitAssociationNode: node [
	| analyzedKey analyzedValue association |
	analyzedKey := self visitNode: node key.
	analyzedValue := node value ifNotNil: [:val | self visitNode: val].
	association := SoNAssociationGraphNode new
		sourcePosition: node sourcePosition;
		key: analyzedKey;
		value: analyzedValue;
		yourself.
	currentRegion addInstruction: association.
	^ association
	
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitBinaryExpressionSequenceNode: node [
	| receiver operator operand messageSend |
	self assert: node elements size >= 1. 
	receiver := self visitNode: node elements first.
	2 to: node elements size by: 2 do: [ :i |
		operator := self visitNode: (node elements at: i).
		operand := self visitNode: (node elements at: i + 1).
		messageSend := SoNSendMessageGraphNode new
			receiver: receiver;
			selector: operator;
			arguments: { operand }.
		currentRegion addInstruction: messageSend.
		receiver := messageSend
	].
	^ receiver
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitBindableNameNode: node [
	^ self error: 'A bindable name requires an initial value assignment.'
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitDictionaryNode: node [
	| analyzedElements dictionary |
	analyzedElements := node elements collect: [ :each | self visitNode: each ].
	dictionary := SoNDictionaryGraphNode new
		sourcePosition: node sourcePosition;
		elements: analyzedElements;
		yourself.
	currentRegion addInstruction: dictionary.
	^ dictionary
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitIdentifierReferenceNode: node [
	| symbolToFind binding |
	symbolToFind := node name.
	binding := environment lookupRecursively: symbolToFind.
	^ binding evaluateASGIn: node sourcePosition.
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitIfConditionNode: node [
	| analyzedCondition analyzedTrueResult analyzedFalseResult trueRegion falseRegion mergeRegion trueResult falseResult trueResultType falseResultType mergePhi startingRegion |
	analyzedCondition := self visitNode: node condition withExpectedType: Boolean.
	trueRegion := nil.
	trueResult := nil.
	falseRegion := nil.
	falseResult := nil.
	mergeRegion := SoNRegionGraphNode new.
	mergeRegion immediateDominator: currentRegion.
	analyzedTrueResult := node trueResult ifNotNil: [:action |
		trueRegion := SoNRegionGraphNode new
			addPredecessor: currentRegion;
			addSuccessor: mergeRegion;
			immediateDominator: currentRegion;
			yourself.
		currentRegion addSuccessor: trueRegion.
		
		trueResult := self visitNode: action withRegion: trueRegion.
	] ifNil: [
		currentRegion addSuccessor: mergeRegion.
		mergeRegion addPredecessor: currentRegion.
	].
	analyzedFalseResult := node falseResult ifNotNil: [:action|
		falseRegion := SoNRegionGraphNode new
			addPredecessor: currentRegion;
			addSuccessor: mergeRegion;
			immediateDominator: currentRegion;
			yourself.
		currentRegion addSuccessor: falseRegion.

		falseResult := self visitNode: action withRegion: falseRegion.
	] ifNil: [
		currentRegion addSuccessor: mergeRegion.
		mergeRegion addPredecessor: currentRegion.
	].
 
	currentRegion addInstruction: (SoNConditionalBranchGraphNode new
		sourcePosition: node sourcePosition;
		condition: analyzedCondition;
		trueDestination: (trueRegion ifNil: [mergeRegion]);
		falseDestination: (falseRegion ifNil: [mergeRegion]);
		mergeDestination: mergeRegion).
	startingRegion := currentRegion.
	currentRegion := mergeRegion.
	
	(trueResult isNil or: [falseResult isNil]) ifTrue: [
		^ SoNLiteralValueGraphNode voidValue
	].

	trueResultType := trueResult type asDecayedSysmelType .
	falseResultType := falseResult type asDecayedSysmelType .
	trueResultType = falseResultType ifTrue: [
		mergePhi := SoNPhiGraphNode new
							sourcePosition: node sourcePosition;
							type: falseResultType;
							yourself.
		mergeRegion addMergePhi: mergePhi.
		trueRegion addPhiCopy: (SoNPhiCopyGraphNode new
			value: trueResult;
			type: trueResultType;
			destination: mergePhi;
			yourself).
		falseRegion addPhiCopy: (SoNPhiCopyGraphNode new
			value: falseResult;
			type: falseResultType;
			destination: mergePhi;
			yourself).
		^ mergePhi
	] ifFalse: [
		^ SoNLiteralValueGraphNode voidValue
	]
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLexicalBlockNode: node [
	| childEnvironment oldEnvironment |
	childEnvironment := (SysmelLexicalEnvironment parent: environment)
		sourcePosition: node sourcePosition;
		yourself.
	oldEnvironment := environment.
	environment := childEnvironment.
	
	^ [
		self visitNode: node body
	] ensure: [ environment := oldEnvironment ]
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralCharacterNode: node [
	^ SoNLiteralValueGraphNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Character;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralFloatNode: node [
	^ SoNLiteralValueGraphNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Float;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralFunctionNode: node [
	^ SoNLiteralValueGraphNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: node value type;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralIntegerNode: node [
	^ SoNLiteralValueGraphNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Integer;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralStringNode: node [
	^ SoNLiteralValueGraphNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: String;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralSymbolNode: node [
	^ SoNLiteralValueGraphNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Symbol;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitMessageCascadeMessageNode: node [
	self error: 'A cascade message requires a cascade.'
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitMessageCascadeNode: node [
	| receiver lastResult |
	receiver := self visitNode: node receiver.
	lastResult := receiver.
	node messages do: [ :eachMessage |
		| selector arguments messageSend|
		selector := self visitAndEvaluateSymbolValue: eachMessage selector.
		arguments := eachMessage arguments collect: [ :eachArgument | self visitNode: eachArgument ].
		lastResult := messageSend := SoNSendMessageGraphNode new
			sourcePosition: eachMessage sourcePosition;
			receiver: receiver;
			selector: selector;
			arguments: arguments;
			yourself.
		currentRegion addInstruction: messageSend
	].
	^ lastResult
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitMessageSendNode: node [
	| receiver selector arguments instruction |
	node receiver ifNil: [
		| functionBinding application |
		selector := self visitAndEvaluateSymbolValue: node selector.
		functionBinding := environment lookupRecursively: selector.
		functionBinding ifNil: [ self error: 'Failed to find global function or macro named: ' , selector ].
		application := SysmelParseTreeApplicationNode new
			sourcePosition: node sourcePosition;
			functional: (SysmelParseTreeLiteralFunction new
				sourcePosition: node sourcePosition;
				value: functionBinding value);
			arguments: node arguments;
			yourself.
		^ self visitNode: application 
	].

	receiver := self visitNodeWithoutTypeCoercion: node receiver.
	selector := self visitAndEvaluateSymbolValue: node selector.
	arguments := node arguments collect: [:each | self visitNode: each].
	instruction := SoNSendMessageGraphNode new
						sourcePosition: node sourcePosition;
						receiver: receiver;
						selector: selector;
						arguments: arguments;
						type: SysmelTypeGradual uniqueInstance;
						yourself.
	currentRegion addInstruction: instruction.
	^ instruction
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNode: node withExpectedType: anExpectedType [
	| visitedNode |
	visitedNode := self visitNode: node.
	(visitedNode type isSubtypeOf: anExpectedType) ifFalse: [
		self error: node sourcePosition printString , 'Cannot coerce node through subtyping.'
	].
	^ visitedNode
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNode: aNode withRegion: aRegionOfCode [
	| oldRegion |
	oldRegion := currentRegion.
	currentRegion := aRegionOfCode.
	^ [ self visitNode: aNode ] ensure: [ currentRegion := oldRegion ]
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNodeWithTypeCoercion: aNode [
	^ self coerceNode: (self visitNode: aNode) into: expectedType
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNodeWithValueDecay: aNode [
	self flag: 'TODO: Implement this.'.
	^ self visitNode: aNode
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNodeWithoutTypeCoercion: aNode [
	^ self withoutExpectedTypeDo:  [
		self visitNode: aNode
	]
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitSequenceNode: node [
	| lastIndex analyzedElements |
	node elements isEmpty ifTrue: [ 
		^ SoNLiteralValueGraphNode new
			sourcePosition: node sourcePosition;
			value: SysmelVoidType uniqueInstance;
			type: SysmelVoidType;
			yourself
	].

	node elements size = 1 ifTrue: [
		^ self visitNodeWithTypeCoercion: node elements first
	].

	lastIndex := node elements size.
	analyzedElements := node elements collectWithIndex: [ :element :index |
		index < lastIndex ifTrue: [
			self visitNodeWithoutTypeCoercion: element.
		] ifFalse: [
			self visitNodeWithTypeCoercion: element
		]
	].
	^ currentRegion addInstruction: (SoNSequencingGraphNode new
		sourcePosition: node sourcePosition;
		elements: analyzedElements;
		type: analyzedElements last type;
		yourself)
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitTupleNode: node [
	| analyzedElements analyzedElementTypes tupleType |
	analyzedElements := node elements collect: [ :each | self visitNodeWithValueDecay: each ].
	analyzedElements size >= 1 ifTrue: [
		(analyzedElements allSatisfy: [ :each | each isValidSysmelType ]) ifTrue: [
			^ SysmelProductType new
				sourcePosition: node sourcePosition;
				elements: analyzedElements;
				yourself
		].
	].
	analyzedElementTypes := analyzedElements collect: [ :each | each type ].
	tupleType := SysmelProductType new
			sourcePosition: node sourcePosition;
			elements: analyzedElementTypes;
			yourself.
			
	^ currentRegion addInstruction: (SoNTupleGraphNode new
		sourcePosition: node sourcePosition;
		elements: analyzedElements;
		type: tupleType;
		yourself)
]

{ #category : 'enumerating' }
SysmelParseTreeSemanticAnalyzer >> withoutExpectedTypeDo: aBlock [
	| oldExpectedType |
	oldExpectedType := expectedType.
	expectedType := nil.
	^ aBlock ensure: [
		expectedType := oldExpectedType
	]
]
