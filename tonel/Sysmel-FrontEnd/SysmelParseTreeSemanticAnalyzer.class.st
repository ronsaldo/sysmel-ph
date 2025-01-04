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
	| asg returnInstruction |
	environment := newEnvironment.
	expectedType := anExpectedType.
	currentRegion := region.
	asg := self visitNode: ast.
	
	returnInstruction := SoNReturnNode new
		type: asg type;
		value: asg;
		yourself.
	currentRegion addInstruction: returnInstruction.
	^ SeaOfNodesCode new
		startingRegion: region;
		endingRegions: { currentRegion }
		yourself
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> analyzeArgumentNode: node withIndex: eachArgumentIndex [
	| name typeExpression binding |
	self assert: node isBindableNameNode.
	name := self evaluateOptionalSymbol: node nameExpression.
	typeExpression := self visitOptionalTypeExpression: node typeExpression.
	typeExpression ifNil: [
		typeExpression := SoNLiteralValueGraphNode new
			value: SysmelTypeGradual uniqueInstance;
			type: SysmelTypeGradual type
	].
	binding := SymbolArgumentBinding new
		sourcePosition: node sourcePosition;
		name: name;
		index: eachArgumentIndex;
		typeExpression: typeExpression;
		isImplicit: node isImplicit;
		yourself.
	^ SoNArgumentGraphNode new
		sourcePosition: node sourcePosition;
		type: typeExpression;
		binding: binding;
		isImplicit: node isImplicit;
		isExistential: node isExistential;
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

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> evaluateOptionalSymbol: aNode [
	| symbolNode |
	aNode ifNil: [ ^ nil ].
	
	symbolNode := self visitNode: aNode.
	^ symbolNode value
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> reducePiNode: piNode [
	self flag: 'TODO: Implement this optimization.'.
	^ piNode
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
	| analyzedValue analyzedStore valueType alloca baseType coercedValue expandedStore lambda functionExpression initialStore |
	expandedStore := self visitNodeForMacroExpansionOnly: node store.
	expandedStore isFunctionalDependentTypeNode ifTrue: [
		lambda := SysmelParseTreeFunctionNode new
			sourcePosition: node sourcePosition;
			nameExpression: nil;
			functionalType: expandedStore;
			body: node value;
			isFixpoint: false;
			yourself.
		^ self visitNode: lambda
	].
	node store isBindableNameNode ifTrue: [
		| bindableName name |
		bindableName := expandedStore.
		(bindableName typeExpression isNotNil and: [ bindableName typeExpression isFunctionalDependentTypeNode ]) ifTrue: [
			functionExpression := SysmelParseTreeFunctionNode new
				sourcePosition: node sourcePosition;
				nameExpression: bindableName nameExpression;
				functionalType: bindableName typeExpression;
				body: node value;
				isFixpoint: bindableName hasPostTypeExpression;
				yourself.
			^ self visitNode: functionExpression.
		].
		
		analyzedValue := node value ifNotNil: [self visitNode: node value ].
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
			
			analyzedValue ifNotNil: [
				initialStore := SoNStoreValueGraphNode new
					pointer: alloca;
					value: analyzedValue;
					yourself.
				currentRegion addInstruction: initialStore.
			].
			environment addSymbol: name valueBinding: alloca.				
		] ifFalse: [ 
			environment addSymbol: name valueBinding: analyzedValue.
		].
		^ analyzedValue
	].

	analyzedStore := self visitNode: expandedStore.
	analyzedValue := node value ifNotNil: [self visitNode: node value ].
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
	self assert: node elements isNotEmpty. 
	node elements size = 1 ifTrue: [ ^ self visitNode: node elements first ].
	
	receiver := node elements first.
	2 to: node elements size by: 2 do: [ :i |
		operator := node elements at: i.
		operand := node elements at: i + 1.
		messageSend := SysmelParseTreeMessageSendNode new
			sourcePosition: node sourcePosition;
			receiver: receiver;
			selector: operator;
			arguments: { operand };
			yourself.

		receiver := messageSend
	].
	^ self visitNode: receiver
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
SysmelParseTreeSemanticAnalyzer >> visitFunctionNode: functionNode [
	| functionalType lambda lambdaAnalyzed |
	functionalType	:= self visitNodeForMacroExpansionOnly: functionNode functionalType.
	functionalType isFunctionalDependentTypeNode ifFalse: [
		self error: 'Expected a function type expression.'
	].
	lambda := functionalType constructLambdaWithName: functionNode nameExpression body: functionNode body isFixpoint: functionNode isFixpoint.
	lambdaAnalyzed := self visitNode: lambda.
	lambdaAnalyzed name ifNotNil: [
		environment addSymbol: lambdaAnalyzed name valueBinding: lambdaAnalyzed
	].
	^ lambdaAnalyzed
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitFunctionalDependentNode: node [
	| argumentsAndFlags argumentNodes isExistential isVariadic |
	node argumentPattern ifNil: [
		^ self visitNode: (SysmelParseTreePiNode new
			sourcePosition: node sourcePosition;
			arguments: #();
			isVariadic: false;
			body: node resultType;
			callingConvention: node callingConvention;
			yourself)
	].

	argumentsAndFlags := node argumentPattern parseAndUnpackArgumentsPattern.
	argumentNodes := argumentsAndFlags first.
	isExistential := argumentsAndFlags second.
	isVariadic := argumentsAndFlags third.
	
	isExistential ifTrue: [
		^ self visitNode: (SysmelParseTreeSigmaNode new
			sourcePosition: node sourcePosition;
			arguments: argumentNodes;
			body: node resultType;
			yourself) 
	] ifFalse: [
		^ self visitNode: (SysmelParseTreePiNode new
			sourcePosition: node sourcePosition;
			arguments: argumentNodes;
			isVariadic: false;
			body: node resultType;
			callingConvention: node callingConvention;
			yourself)
	]
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
	| analyzedCondition analyzedTrueResult analyzedFalseResult trueRegion falseRegion mergeRegion trueResult falseResult trueResultType falseResultType mergePhi startingRegion trueResultAndEndingRegion trueEndingRegion falseResultAndEndingRegion falseEndingRegion |
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
		
		trueResultAndEndingRegion:= self visitNode: action withRegion: trueRegion.
		trueResult := trueResultAndEndingRegion first.
		trueEndingRegion := trueResultAndEndingRegion second.
		
		trueEndingRegion addInstruction: (SoNBranchGraphNode new
			sourcePosition: node sourcePosition;
			destination: mergeRegion;
			yourself).
		trueEndingRegion addSuccessor: mergeRegion.
		mergeRegion addPredecessor: trueEndingRegion.
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

		falseResultAndEndingRegion := self visitNode: action withRegion: falseRegion.
		falseResult := falseResultAndEndingRegion first.
		falseEndingRegion := falseResultAndEndingRegion second.
		
		falseEndingRegion addInstruction: (SoNBranchGraphNode new
			sourcePosition: node sourcePosition;
			destination: mergeRegion;
			yourself).
		falseEndingRegion addSuccessor: mergeRegion.
		mergeRegion addPredecessor: falseRegion.
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
SysmelParseTreeSemanticAnalyzer >> visitLambdaNode: node [
	| functionalEnvironment typedArguments typedArgument analyzedResultTypeExpression name typedPi typeUniverse fixpointBinding body bodyType bodyRegion bodyEndingRegion returnNode |
	functionalEnvironment := SysmelFunctionalAnalysisEnvironment parent: environment.
	typedArguments := OrderedCollection new.
	node arguments doWithIndex: [ :eachArgument :eachArgumentIndex|
		typedArgument := 
			self withEnvironment: functionalEnvironment
			do: [ self analyzeArgumentNode: eachArgument withIndex: eachArgumentIndex ].
		functionalEnvironment := functionalEnvironment withArgumentBinding: typedArgument binding.
		typedArguments add: typedArgument
	]. 
	
	" Analyze here the result type expression, so that we can introduce the fixpoint binding without poluting the environment"
	analyzedResultTypeExpression := nil.
	node resultType ifNotNil: [
		analyzedResultTypeExpression := self withEnvironment: functionalEnvironment do: [ self visitTypeExpression: node resultType ]
	].

	name := self evaluateOptionalSymbol: node nameExpression.
	
	"Construct the dependent type without result type inference."
	typedPi := nil.
	(analyzedResultTypeExpression isNotNil or: [ node isFixpoint and name isNotNil ]) ifTrue: [
		typeUniverse := SysmelTypeUniverse withIndex: 0.
		typedPi := SoNPiNode new
			sourcePosition: node sourcePosition;
			name: nil;
			type: typeUniverse;
			arguments: typedArguments;
			isVariadic: node isVariadic;
			captureBindings: functionalEnvironment captureBindings;
			body: analyzedResultTypeExpression;
			callingConvention: node callingConvention;
			yourself.
		typedPi := self reducePiNode: typedPi
	].
	
	"Add the fixpoint symbol"
	fixpointBinding := nil.
	(node isFixpoint and: [name isNotNil ]) ifTrue: [
		fixpointBinding := SymbolFixpointBinding new
			sourcePosition: node sourcePosition;
			name: name;
			typeExpression: typedPi;
			yourself.
		functionalEnvironment := functionalEnvironment withFixpointBinding: fixpointBinding
	].
	
	"Analyze the body"
	bodyRegion := SoNRegionGraphNode new
		sourcePosition: node sourcePosition;
		yourself.
	bodyEndingRegion := bodyRegion.
	body := self withEnvironment: functionalEnvironment region: bodyRegion do: 
		[ | bodyValue | bodyValue := self visitNode: node body withExpectedTypeExpression: analyzedResultTypeExpression.
		bodyEndingRegion := currentRegion.
		bodyValue].
	
	"Compute the lambda type"
	bodyType := body type.
	typeUniverse := SysmelTypeUniverse withIndex: 0.
	
	typedPi ifNil: [
		self halt
	].

	"Return"
	returnNode := SoNReturnNode new
		sourcePosition: node sourcePosition;
		type: body type;
		value: body;
		yourself.
	bodyEndingRegion addInstruction: returnNode.

	"Make the typed lambda node"	
	^ SoNLambdaNode new
		sourcePosition: node sourcePosition;
		name: name;
		type: typedPi;
		arguments: typedArguments;
		isVariadic: node isVariadic;
		captureBindings: functionalEnvironment captureBindings;
		body: returnNode;
		callingConvention: node callingConvention;
		seaOfNodesCode: (SeaOfNodesCode new
			startingRegion: bodyRegion;
			endingRegions: { bodyEndingRegion };
			yourself)
		yourself
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
		arguments := eachMessage arguments collect: [ :eachArgument | self visitNodeLoadingReferences: eachArgument ].
		lastResult := messageSend := SoNSendMessageGraphNode new
			sourcePosition: eachMessage sourcePosition;
			receiver: receiver;
			selector: (SoNLiteralValueGraphNode new
						sourcePosition: node sourcePosition;
						value: selector;
						type: Symbol;
						yourself);
			arguments: arguments;
			yourself.
		currentRegion addInstruction: messageSend
	].
	^ lastResult
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitMessageSendNode: node [
	| receiver selector arguments instruction method resultType receiverValue argumentsValues resultValue |
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
	method := receiver type lookupSelector: selector.
	
	(method isNotNil and: [method hasPragmaNamed: #sysmelMacro]) ifTrue: [ 
		self halt
	].
	arguments := node arguments collect: [:each | self visitNode: each].

	resultType := SysmelTypeGradual uniqueInstance.
	(method isNotNil and: [ method hasPragmaNamed: #resultType: ]) ifTrue: [
		| resulTypeName foundType |
		resulTypeName := (method pragmaAt: #resultType:) arguments first.
		foundType := (environment lookupRecursively: resulTypeName) value.
		foundType ifNotNil: [ resultType := foundType ]
	].

	(method isNotNil
		and: [(method hasPragmaNamed: #pure)
		and: [receiver isConstantDataNode
		and: [arguments allSatisfy: [:each | each isConstantDataNode]]]]) ifTrue: [
		receiverValue := receiver asConstantValueForPureEvaluation.
		argumentsValues := arguments collect: [ :eachArg | eachArg asConstantValueForPureEvaluation ].
		resultValue := receiverValue perform: selector withArguments: argumentsValues.
		^ SoNLiteralValueGraphNode new
			sourcePosition: node sourcePosition;
			value: resultValue;
			type: resultValue asSysmelType;
			yourself
	].
	
	instruction := SoNSendMessageGraphNode new
						sourcePosition: node sourcePosition;
						receiver: receiver;
						selector: (SoNLiteralValueGraphNode new
							sourcePosition: node sourcePosition;
							value: selector;
							type: Symbol;
							yourself);
						arguments: arguments;
						type: resultType;
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
SysmelParseTreeSemanticAnalyzer >> visitNode: node withExpectedTypeExpression: expectedTypeExpression [
	| visitedNode |
	visitedNode := self visitNode: node.
	self flag: 'Perform the type checking'.
	^ visitedNode
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNode: aNode withRegion: aRegionOfCode [
	| oldRegion |
	oldRegion := currentRegion.
	currentRegion := aRegionOfCode.
	^ [ {self visitNode: aNode . currentRegion } ] ensure: [ currentRegion := oldRegion ]
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNodeForMacroExpansionOnly: node [
	self flag: 'TODO: Implement this'.
	^ node
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNodeLoadingReferences: node [
	| visitedNode nodeType decayedNodeType loadInstruction |
	visitedNode := self visitNode: node.
	nodeType := visitedNode type.
	decayedNodeType := nodeType asDecayedSysmelType.
	nodeType = decayedNodeType ifTrue: [ ^ visitedNode ].
	nodeType isReferenceLikeType ifTrue: [
		loadInstruction := SoNLoadValueGraphNode new
			sourcePosition: node sourcePosition;
			pointer: visitedNode;
			yourself.
		currentRegion addInstruction: loadInstruction.
		^ loadInstruction
	].
	self halt
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

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> visitOptionalTypeExpression: aTypeExpression [
	aTypeExpression ifNil: [ ^ nil ].
	^ self visitTypeExpression: aTypeExpression
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitPiNode: node [
	| functionalEnvironment typedArguments typedArgument body typeUniverse piNode |
	functionalEnvironment := SysmelFunctionalAnalysisEnvironment parent: environment.
	typedArguments := OrderedCollection new.
	node arguments doWithIndex: [ :argumentNode :argumentIndex |
		typedArgument := self withEnvironment: functionalEnvironment do: [self analyzeArgumentNode: argumentNode withIndex: argumentIndex].
		functionalEnvironment := functionalEnvironment withArgumentBinding: typedArgument binding.
		typedArguments add: typedArgument.
	].

	node body ifNil: [
		body := SoNLiteralValueGraphNode new
			sourcePosition: node sourcePosition;
			value: SysmelTypeGradual uniqueInstance;
			type: SysmelTypeGradual type;
			yourself
	] ifNotNil: [
		body := self withEnvironment: functionalEnvironment do: [self visitTypeExpression: node body].
	].
	
	typeUniverse := SysmelTypeUniverse withIndex: 0.
	piNode := SoNPiNode new
		sourcePosition: node sourcePosition;
		name: nil;
		type: typeUniverse;
		arguments: typedArguments;
		isVariadic: node isVariadic;
		captureBindings: functionalEnvironment captureBindings;
		body: body;
		callingConvention: node callingConvention;
		yourself.
	^ self reducePiNode: piNode
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
SysmelParseTreeSemanticAnalyzer >> visitSigmaNode: node [
	self halt
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

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> visitTypeExpression: aTypeExpression [
	| analyzedNode |
	analyzedNode := self visitNode: aTypeExpression.
	analyzedNode isTypeNode ifTrue: [
		^ analyzedNode
	].

	self halt
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> withEnvironment: newEnvironment do: aBlock [
	| oldEnvironment |
	oldEnvironment := environment.
	environment := newEnvironment.
	^ aBlock ensure: [ environment := oldEnvironment ]
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> withEnvironment: newEnvironment region: aRegion do: aBlock [
	| oldEnvironment oldRegion |
	oldEnvironment := environment.
	oldRegion := currentRegion.
	currentRegion := aRegion.
	environment := newEnvironment.
	^ aBlock ensure: [
		environment := oldEnvironment.
		currentRegion := oldRegion
	]
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
