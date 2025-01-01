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
	^ { asg . region }
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
SysmelParseTreeSemanticAnalyzer >> visitIdentifierReferenceNode: node [
	| symbolToFind binding |
	symbolToFind := node name.
	binding := environment lookupRecursively: symbolToFind.
	^ binding evaluateASGIn: node sourcePosition.
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
		^ currentRegion addInstruction: (SoNSequencingGraphNode new
			sourcePosition: node sourcePosition;
			elements: #();
			type: SysmelVoidType uniqueInstance;
			yourself)
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
