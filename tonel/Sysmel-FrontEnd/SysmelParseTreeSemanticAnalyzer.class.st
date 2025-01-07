Class {
	#name : 'SysmelParseTreeSemanticAnalyzer',
	#superclass : 'SysmelParseTreeVisitor',
	#instVars : [
		'environment',
		'expectedType'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> analyzeAST: ast withEnvironment: newEnvironment [
	^ self analyzeAST: ast withEnvironment: newEnvironment andExpectedType: nil
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> analyzeAST: ast withEnvironment: newEnvironment andExpectedType: anExpectedType [
	| oldEnvironment oldExpectedType |
	oldEnvironment := environment.
	oldExpectedType := expectedType.
	environment := newEnvironment.
	expectedType := anExpectedType.
	^ [
		self visitNode: ast
	] ensure: [
		environment := oldEnvironment.
		expectedType := oldExpectedType.
	]
	 
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> analyzeArgumentNode: node withIndex: eachArgumentIndex [
	| name typeExpression binding |
	self assert: node isBindableNameNode.
	name := self evaluateOptionalSymbol: node nameExpression.
	typeExpression := self visitOptionalTypeExpression: node typeExpression.
	typeExpression ifNil: [  
		typeExpression := SysmelTypedLiteralNode new
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
	^ SysmelTypedArgumentNode new
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
	(aNode type isGradualType or: [ targetType isGradualType ]) ifTrue: [ ^ aNode ].
	
	targetType isVoid ifTrue: [ ^ aNode ].
	self error: ('{1} Cannot coerce from {2} into {3}' format: {
		aNode sourcePosition printString . aNode type printString. targetType printString
	})
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> computeMergeTypeFor: trueResultType and: falseResultType [
	trueResultType = falseResultType ifTrue: [ ^ trueResultType ].
	(trueResultType isGradualType or: [ falseResultType isGradualType ])
		ifTrue: [ ^ SysmelTypeGradual uniqueInstance ].
	^ SysmelVoidType
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> evaluateOptionalSymbol: aNode [
	| symbolNode |
	aNode ifNil: [ ^ nil ].
	
	symbolNode := self visitNode: aNode.
	^ symbolNode value
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> processCascadeMessage: message withReceiver: receiver [
	| selector |
	selector := self visitAndEvaluateSymbolValue: message selector.
	^ self processMessage: message withReceiver: receiver selector: selector arguments: message arguments
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> processMessage: message withReceiver: uncoercedReceiver selector: selector arguments: arguments [
	| receiver method analyzedArguments resultType |

	receiver := uncoercedReceiver.
	receiver type isReferenceLikeType ifTrue: [
		(receiver type supportsSelector: selector) ifTrue: [
			self halt.
		] ifFalse: [
			| loadedReceiver |
			loadedReceiver := SysmelTypedLoadNode new
				sourcePosition: message sourcePosition;
				pointer: receiver;
				type: receiver type asDecayedSysmelType;
				yourself.
			receiver := loadedReceiver
		]
	].

	receiver isSysmelNamespace ifTrue: [
		| namespaceChild |
		namespaceChild := receiver lookChildNamed: selector.
		namespaceChild ifNil: [
			self error: ('Failed to find {1} in namespace-like {2} ' format: {selector, receiver name})
		].
		^ SysmelTypedLiteralNode new
			sourcePosition: message sourcePosition;
			value: namespaceChild;
			type: namespaceChild type;
			yourself
	].
	method := receiver type lookupSelector: selector.
	self flag: 'Use the method typeinfo'.
	analyzedArguments := arguments collect: [ :each | self visitNode: each ].
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
		| receiverValue argumentsValues resultValue |
		receiverValue := receiver asConstantValueForPureEvaluation.
		argumentsValues := arguments collect: [ :eachArg | eachArg asConstantValueForPureEvaluation ].
		resultValue := receiverValue perform: selector withArguments: argumentsValues.

		^ SysmelTypedLiteralNode new
			sourcePosition: message sourcePosition;
			value: resultValue;
			type: resultValue type;
			yourself
	].

	^ SysmelTypedMessageSendNode new
		sourcePosition: message sourcePosition;
		receiver: receiver;
		selector: selector;
		arguments: analyzedArguments;
		type: resultType;
		yourself
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> reducePiNode: piNode [
	self flag: 'TODO: implement this'.
	^ piNode
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitAndEvaluateSymbolValue: node [
	| analyzedNode |
	analyzedNode := self visitNode: node.
	self assert: analyzedNode isLiteralNode.
	self assert: analyzedNode value isSymbol.
	^ analyzedNode value
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitApplicationNode: node [
	| analyzedFunctional analyzedFunctionalType analyzedArguments application isMacro macroArguments macroResult analyzedResultType |
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

	analyzedFunctional value isValidSysmelType ifTrue: [
		^ self visitNode: (SysmelParseTreeInstantiateTypeNode new
			sourcePosition: node sourcePosition;
			type: analyzedFunctional value;
			constructorValues: node arguments;
			yourself
		)
	].
	
	analyzedArguments := node arguments collectWithIndex: [ :arg :index |
		self visitNode: arg
	].

	analyzedResultType := analyzedFunctionalType computeResultTypeWithAnalyzedArguments: analyzedArguments.
	application := SysmelTypedApplicationNode new
		sourcePosition: node sourcePosition;
		functional: analyzedFunctional;
		arguments: analyzedArguments;
		type: analyzedResultType;
		yourself.
	^ application
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitAssignmentNode: node [
	| expandedStore alloca initialStore analyzedStore analyzedValue baseType coercedValue |
	expandedStore := self visitNodeForMacroExpansionOnly: node store.
	expandedStore isFunctionalDependentTypeNode ifTrue: [
		| lambda |
		lambda := SysmelParseTreeFunctionNode new
			sourcePosition: node sourcePosition;
			nameExpression: nil;
			functionalType: expandedStore;
			body: node value;
			isFixpoint: false;
			yourself.
		^ self visitNode: lambda
	].

	expandedStore isBindableNameNode ifTrue: [
		| bindableName analyzedValue name valueType |
		bindableName := expandedStore.
		(bindableName typeExpression isNotNil and: [ bindableName typeExpression isFunctionalDependentTypeNode ]) ifTrue: [
			| functionExpression |
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
			alloca := SysmelTypedAllocaNode new
				sourcePosition: bindableName sourcePosition;
				valueType: valueType;
				type: (SysmelReferenceType withBaseType: valueType);
				exportableName: name;
				yourself.
			
			analyzedValue ifNotNil: [
				initialStore := SysmelTypedStoreNode new
					sourcePosition: node sourcePosition;
					pointer: alloca;
					value: analyzedValue;
					yourself
			].
			environment addSymbol: name valueBinding: alloca.
			
			initialStore 
				ifNil: [ ^ alloca ]
				ifNotNil: [ ^ SysmelTypedSequenceNode new
						sourcePosition: node sourcePosition;
						expressions: { alloca . initialStore . alloca};
						type: alloca type;
						yourself
			]
		] ifFalse: [ 
			environment addSymbol: name valueBinding: analyzedValue.
			(analyzedValue class lookupSelector: #exportableName:) ifNotNil: [ 
				analyzedValue exportableName: name
			]
		].
		^ analyzedValue
	].

	analyzedStore := self visitNode: expandedStore.
	analyzedValue := node value ifNotNil: [self visitNode: node value ].
	analyzedStore type isReferenceLikeType ifTrue: [
		baseType := analyzedStore type asDecayedSysmelType.
		coercedValue := self coerceNode: analyzedValue into: baseType.
		^ SysmelTypedStoreNode new
			sourcePosition: node sourcePosition;
			pointer: analyzedStore;
			value: coercedValue;
			yourself
	].

	self error: 'Cannot perform this assignment' atSourcePosition: node sourcePosition
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
SysmelParseTreeSemanticAnalyzer >> visitEnumElements: dictionary withBaseType: baseType [
	| extractedElements nextElementValue |
	self assert: dictionary isDictionaryNode.
	extractedElements := OrderedCollection new.
	nextElementValue := baseType zero.

	dictionary elements doWithIndex: [:association :index |
		| elementName elementValue |
		elementName := self visitAndEvaluateSymbolValue: association key.
		association value ifNil: [
			elementValue := nextElementValue.
		] ifNotNil: [
			| visitedValue |
			visitedValue := self visitNode: association value.
			self assert: visitedValue isLiteralNode.
			elementValue := visitedValue value.
		].
		
		nextElementValue := elementValue increment.
		extractedElements add: elementName -> elementValue
	].
	^ extractedElements
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitEnumNode: node [
	| parentNamespace baseType parsedElement enumType |
	parentNamespace := environment getNamespace.
	baseType := (self visitTypeExpression: node baseType) value.
	parsedElement := self visitEnumElements: node elements withBaseType: baseType.
	self assert: node name isSymbol.
	
	enumType := SysmelEnumType new
		optionalName: node name;
		baseType: baseType;
		elements: parsedElement;
		yourself.
	parentNamespace exportChild: enumType withName: enumType optionalName.
	^ SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: enumType;
		type: (SysmelTypeUniverse withIndex: 0);
		yourself

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
	binding ifNil: [
		self error: ('Failed to find a binding for {1}.' format: symbolToFind) atSourcePosition: node sourcePosition.
	].

	^ binding evaluateASGIn: node sourcePosition.
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitIfConditionNode: node [
	| condition trueResult falseResult mergeType |
	condition := self visitNode: node condition withExpectedTypeExpression: Boolean.
	trueResult := self visitNode: node trueResult.
	falseResult := self visitNode: node falseResult.
	
	mergeType := self computeMergeTypeFor: trueResult type and: falseResult type.
	
	^ SysmelTypedIfNode new
		sourcePosition: node sourcePosition;
		condition: condition;
		trueResult: trueResult;
		falseResult: falseResult;
		type: mergeType;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitInstantiateTypeNode: node [
	| constructorArguments analyzedConstructorArguments hasDictionaryConstruction |
	node type isTupleType ifFalse: [ self error: 'Only structs and tuples are supported right now.' ].
	constructorArguments := node constructorValues.
	hasDictionaryConstruction := (constructorArguments size = 1 and: [ constructorArguments first isDictionaryNode ]).
	analyzedConstructorArguments := constructorArguments collect: [ :each | self visitNode: each ].

	^ (node type isStructType
		ifTrue: [ SysmelTypedStructNode ]
		ifFalse: [SysmelTypedTupleNode] ) new
		sourcePosition: node sourcePosition;
		type: node type;
		elements: analyzedConstructorArguments;
		hasDictionaryAsInput: hasDictionaryConstruction;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLambdaNode: node [
	| functionalEnvironment typedArguments typedArgument analyzedResultTypeExpression name typedPi typeUniverse fixpointBinding body bodyType lambdaValue |
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
		typedPi := SysmelTypedPiNode new
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
	
	typedPi ifNil: [
		self halt
	].
	
	lambdaValue := SysmelTypedLambdaNode new
		sourcePosition: node sourcePosition;
		name: name;
		type: typedPi;
		arguments: typedArguments;
		isVariadic: node isVariadic;
		captureBindings: functionalEnvironment captureBindings;
		fixpointBinding: functionalEnvironment fixpointBinding;
		closureEnvironment: environment;
		yourself.
		
	"Analyze the body"
	body := self withEnvironment: functionalEnvironment do: 
		[ self visitNode: node body withExpectedTypeExpression: analyzedResultTypeExpression].

	"Decay the references."
	body type isReferenceLikeType ifTrue: [
		| resultLoad |
		resultLoad := SysmelTypedLoadNode new
				sourcePosition: body sourcePosition;
				pointer: body;
				type: body type asDecayedSysmelType;
				yourself.
		body := resultLoad.
	].
	
	"Compute the lambda type"
	bodyType := body type.
	typeUniverse := SysmelTypeUniverse withIndex: 0.


	"Make the typed lambda node"	
	^ lambdaValue
		body: body;
		callingConvention: node callingConvention;
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
	^ SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Character;
		yourself
	
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralFloatNode: node [
	^ SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Float;
		yourself
	
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralFunctionNode: node [
	^ SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: node value type;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralIntegerNode: node [
	^ SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Integer;
		yourself
	
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralStringNode: node [
	^ SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: String;
		yourself
	
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitLiteralSymbolNode: node [
	^ SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: node value;
		type: Symbol;
		yourself
	
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitMessageCascadeNode: cascadeNode [
	| receiver lastResult expressionList |
	cascadeNode receiver ifNil: [ self error: 'Message cascades require a receiver.' atSourcePosition: cascadeNode sourcePosition ].
	receiver := self visitNode: cascadeNode receiver.

	expressionList := OrderedCollection new.
	expressionList add: receiver.
	
	cascadeNode messages do: [ :message |
		lastResult := self processCascadeMessage: message withReceiver: receiver.
		expressionList add: lastResult
	].
	^ SysmelTypedSequenceNode new
		sourcePosition: cascadeNode sourcePosition;
		expressions: expressionList asArray;
		type: lastResult type;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitMessageSendNode: messageSend [
	| receiver selector  |
	messageSend receiver ifNil: [
		| functionBinding application |
		selector := self visitAndEvaluateSymbolValue: messageSend selector.
		functionBinding := environment lookupRecursively: selector.
		functionBinding ifNil: [ self error: 'Failed to find global function or macro named: ' , selector printString atSourcePosition: messageSend sourcePosition ].
		application := SysmelParseTreeApplicationNode new
			sourcePosition: messageSend sourcePosition;
			functional: (SysmelParseTreeLiteralFunction new
				sourcePosition: messageSend sourcePosition;
				value: functionBinding value);
			arguments: messageSend arguments;
			yourself.
		^ self visitNode: application 
	].

	receiver := self visitNode: messageSend receiver.
	selector := self visitAndEvaluateSymbolValue: messageSend selector.
	^ self processMessage: messageSend withReceiver: receiver selector: selector arguments: messageSend arguments
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNamespaceNode: node [
	| parentNamespace childNamespace namespaceEnvironment definitionEnvironment |
	parentNamespace := environment getNamespace.
	childNamespace := parentNamespace getOrCreateSubnamespaceNamed: node name.
	namespaceEnvironment := (SysmelNamespaceEnvironment parent: environment)
									namespace: childNamespace;
									yourself.
	definitionEnvironment := SysmelLexicalEnvironment parent: namespaceEnvironment.
	^ self withEnvironment: definitionEnvironment do: [ self visitNode: node body ]
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNode: node withExpectedTypeExpression: expectedTypeExpression [
	| visitedNode |
	visitedNode := self visitNode: node.
	self flag: 'Perform the type checking'.
	^ visitedNode
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNodeForMacroExpansionOnly: node [
	self flag: 'TODO: Implement this'.
	^ node
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitOptionalTypeExpression: aTypeExpression [
	aTypeExpression ifNil: [ ^ nil ].
	^ self visitTypeExpression: aTypeExpression
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitPublicNode: node [
	| ownerNamespace exportedObject rawExportedObject |
	ownerNamespace := environment getNamespace.
	rawExportedObject := self visitNode: node exportedObject.
	exportedObject := rawExportedObject findAllExportableObjects.
	exportedObject ifEmpty: [ ^ rawExportedObject ].
	exportedObject do: [ :eachObject |
		ownerNamespace exportChild: eachObject withName: eachObject exportableName.
	].
	^ exportedObject last
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitSequenceNode: node [
	| typedSequenceElements sequenceType |
	typedSequenceElements := node elements collect: [:eachElement |
		self visitNode: eachElement
	].
	typedSequenceElements ifEmpty: [
		^ SysmelTypedLiteralNode new
			sourcePosition: node sourcePosition;
			value: SysmelVoidType uniqueInstance;
			type: SysmelVoidType;
			yourself
	].

	sequenceType := typedSequenceElements last type.
	^ SysmelTypedSequenceNode new
		sourcePosition: node sourcePosition;
		expressions: typedSequenceElements;
		type: sequenceType;
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitStructElements: dictionary [
	| extractedElements |
	self assert: dictionary isDictionaryNode.
	extractedElements := OrderedCollection new.
	
	dictionary elements doWithIndex: [:association :index |
		| elementName elementType |
		elementName := self visitAndEvaluateSymbolValue: association key.
		association value ifNil: [
			elementType := SysmelTypeGradual uniqueInstance.
		] ifNotNil: [
			| visitedValue |
			visitedValue := self visitNode: association value.
			visitedValue isValidSysmelType ifTrue: [
				elementType := visitedValue
			] ifFalse: [ 
				self assert: visitedValue isLiteralNode.
				elementType := visitedValue value.
			]
		].
		
		extractedElements add: elementName -> elementType
	].
	^ extractedElements
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitStructNode: node [
	| parentNamespace parsedElement optionalSupertype structType |
	parentNamespace := environment getNamespace.
	optionalSupertype := node supertype ifNotNil: [(self visitTypeExpression: node supertype) value].
	parsedElement := self visitStructElements: node elements.
	self assert: node name isSymbol.
	
	structType := SysmelStructType new
		optionalName: node name;
		supertype: optionalSupertype;
		namedElements: parsedElement;
		yourself.
	parentNamespace exportChild: structType withName: structType optionalName.
	^SysmelTypedLiteralNode new
		sourcePosition: node sourcePosition;
		value: structType;
		type: (SysmelTypeUniverse withIndex: 0);
		yourself
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitTypeExpression: aTypeExpression [
	| analyzedNode |
	analyzedNode := self visitNode: aTypeExpression.
	analyzedNode isTypeNode ifTrue: [
		^ analyzedNode
	].

	self halt
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitWhileLoopNode: node [ 
	| condition body continueExpression |
	condition := self withEnvironment: (SysmelLexicalEnvironment parent: environment) do: [ 
		self visitNode: node condition.
	].
	body := self withEnvironment: (SysmelLexicalEnvironment parent: environment) do: [ 
		self visitOptionalNode: node body.
	].
	continueExpression := self withEnvironment: (SysmelLexicalEnvironment parent: environment) do: [ 
		self visitOptionalNode: node continueExpression.
	].
	
	^ SysmelTypedWhileLoopNode new
		sourcePosition: node sourcePosition;
		condition: condition;
		body: body;
		continueExpression: continueExpression;
		type: SysmelVoidType;
		yourself
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> withEnvironment: newEnvironment do: aBlock [
	| oldEnvironment |
	oldEnvironment := environment.
	environment := newEnvironment.
	^ aBlock ensure: [ environment := oldEnvironment ]
]
