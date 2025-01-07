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
SysmelParseTreeSemanticAnalyzer >> processCascadeMessage: message withReceiver: receiver [
	| selector |
	selector := self visitAndEvaluateSymbolValue: message selector.
	^ self processMessage: message withReceiver: receiver selector: selector arguments: message arguments
]

{ #category : 'as yet unclassified' }
SysmelParseTreeSemanticAnalyzer >> processMessage: message withReceiver: receiver selector: selector arguments: arguments [

	| method analyzedArguments resultType |
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

	^ SysmelTypedMessageSendNode new
		sourcePosition: message sourcePosition;
		receiver: receiver;
		selector: selector;
		arguments: analyzedArguments;
		type: resultType;
		yourself
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
SysmelParseTreeSemanticAnalyzer >> visitAssignmentNode: node [
	| expandedStore |
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
			self halt
		] ifFalse: [ 
			environment addSymbol: name  valueBinding: analyzedValue.
			(analyzedValue class lookupSelector: #exportableName:) ifNotNil: [ 
				analyzedValue exportableName: name
			]
		].
		^ analyzedValue
	].

	self halt.
	self error: 'Cannot perform this assignment' atSourcePosition: node sourcePosition
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
	| receiver selector |
	messageSend receiver ifNil: [
		self halt.
	].

	receiver := self visitNode: messageSend receiver.
	selector := self visitAndEvaluateSymbolValue: messageSend selector.
	^ self processMessage: messageSend withReceiver: receiver selector: selector arguments: messageSend arguments
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitNodeForMacroExpansionOnly: node [
	self flag: 'TODO: Implement this'.
	^ node
]

{ #category : 'visiting' }
SysmelParseTreeSemanticAnalyzer >> visitSequenceNode: node [
	| lastResult |
	lastResult := nil.
	node elements do: [:eachElement |
		lastResult := self visitNode: eachElement
	].

	^ lastResult
]
