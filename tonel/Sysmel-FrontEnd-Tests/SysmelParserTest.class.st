"
A SysmelParserTest is a test class for testing the behavior of SysmelParser
"
Class {
	#name : 'SysmelParserTest',
	#superclass : 'TestCase',
	#category : 'Sysmel-FrontEnd-Tests-Parser',
	#package : 'Sysmel-FrontEnd-Tests',
	#tag : 'Parser'
}

{ #category : 'parsing' }
SysmelParserTest >> parseSourceString: sourceString [
	| sourceCode |
	sourceCode := SysmelSourceCode new
		text: sourceString;
		yourself.
	^ SysmelParser new parseSourceCode: sourceCode
]

{ #category : 'parsing' }
SysmelParserTest >> parseSourceStringWithoutError: string [
	| ast |
	ast := self parseSourceString: string.
	self assert: (SysmelParseTreeErrorVisitor new checkAndPrintErrors: ast).
	^ ast
]

{ #category : 'tests' }
SysmelParserTest >> testApplication [
	| node |
	node := self parseSourceStringWithoutError: 'a()'.
	self assert: node isApplicationNode.
	self assert: node functional isIdentifierReferenceNode.
	self assert: node functional name equals: #a.
]

{ #category : 'tests' }
SysmelParserTest >> testApplication2 [
	| node |
	node := self parseSourceStringWithoutError: 'a(42)'.
	self assert: node isApplicationNode.
	self assert: node functional isIdentifierReferenceNode.
	self assert: node functional name equals: #a.
	
	self assert: node arguments size equals: 1.
	self assert: node arguments first isLiteralIntegerNode.
	self assert: node arguments first value equals: 42
	
]

{ #category : 'tests' }
SysmelParserTest >> testApplication3 [
	| node |
	node := self parseSourceStringWithoutError: 'a(42. 5)'.
	self assert: node isApplicationNode.
	self assert: node functional isIdentifierReferenceNode.
	self assert: node functional name equals: #a.
	
	self assert: node arguments size equals: 2.
	self assert: node arguments first isLiteralIntegerNode.
	self assert: node arguments first value equals: 42.
	
	self assert: node arguments second isLiteralIntegerNode.
	self assert: node arguments second value equals: 5

]

{ #category : 'tests' }
SysmelParserTest >> testAssignment [
	| node |
	node := self parseSourceStringWithoutError: 'a := 42'.
	self assert: node isAssignmentNode .
	self assert: node store isIdentifierReferenceNode.
	self assert: node store name equals: #a.
	
	self assert: node value isLiteralIntegerNode.
	self assert: node value value equals: 42
]

{ #category : 'tests' }
SysmelParserTest >> testAssociation [
	| node |
	node := self parseSourceStringWithoutError: '42 : 5'.
	self assert: node isAssociationNode.

	self assert: node key isLiteralIntegerNode.
	self assert: node key value equals: 42.

	self assert: node value isLiteralIntegerNode.
	self assert: node value value equals: 5.

]

{ #category : 'tests' }
SysmelParserTest >> testBinaryExpressionSequence [
	| node leftOperand operator rightOperand |
	node := self parseSourceStringWithoutError: '1 + 2'.
	self assert: node isBinaryExpressionSequenceNode.
	self assert: node elements size equals: 3.
	
	leftOperand := node elements at: 1.
	self assert: leftOperand isLiteralIntegerNode.
	self assert: leftOperand value equals: 1.
	
	operator := node elements at: 2.
	self assert: operator isLiteralSymbolNode.
	self assert: operator value equals: #+.

	rightOperand := node elements at: 3.
	self assert: rightOperand isLiteralIntegerNode.
	self assert: rightOperand value equals: 2.
	
]

{ #category : 'tests' }
SysmelParserTest >> testBinaryExpressionSequence2 [
	| node leftOperand operator rightOperand operator2 rightOperand2 |
	node := self parseSourceStringWithoutError: '1 + 2 * 5'.
	self assert: node isBinaryExpressionSequenceNode.
	self assert: node elements size equals: 5.
	
	leftOperand := node elements at: 1.
	self assert: leftOperand isLiteralIntegerNode.
	self assert: leftOperand value equals: 1.
	
	operator := node elements at: 2.
	self assert: operator isLiteralSymbolNode.
	self assert: operator value equals: #+.

	rightOperand := node elements at: 3.
	self assert: rightOperand isLiteralIntegerNode.
	self assert: rightOperand value equals: 2.
	
	operator2 := node elements at: 4.
	self assert: operator2 isLiteralSymbolNode.
	self assert: operator2 value equals: #*.

	rightOperand2 := node elements at: 5.
	self assert: rightOperand2 isLiteralIntegerNode.
	self assert: rightOperand2 value equals: 5
]

{ #category : 'tests' }
SysmelParserTest >> testBindableName [
	| node |
	node := self parseSourceStringWithoutError: ':a'.
	self assert: node isBindableNameNode .
	self assert: node nameExpression isLiteralSymbolNode.
	self assert: node typeExpression isNil.
]

{ #category : 'tests' }
SysmelParserTest >> testBindableName2 [
	| node |
	node := self parseSourceStringWithoutError: ':(Integer)a'.
	self assert: node isBindableNameNode .
	self assert: node nameExpression isLiteralSymbolNode.
	self assert: node typeExpression isNotNil.
	self assert: node typeExpression isIdentifierReferenceNode .
	self assert: node typeExpression name equals: #Integer.
]

{ #category : 'tests' }
SysmelParserTest >> testBlock [
	| node |
	node := self parseSourceStringWithoutError: '{| | x}'.
	self assert: node isBlockNode .
	self assert: node body isIdentifierReferenceNode.
	self assert: node body name equals: #x.
]

{ #category : 'tests' }
SysmelParserTest >> testBlock2 [
	| node |
	node := self parseSourceStringWithoutError: '{| :(Integer)x :: Integer | x}'.
	self assert: node isBlockNode .
	self assert: node functionalType isFunctionalDependentTypeNode.
	
	self assert: node body isIdentifierReferenceNode.
	self assert: node body name equals: #x.

]

{ #category : 'tests' }
SysmelParserTest >> testCascadeMessageSend [
	| node |
	node := self parseSourceStringWithoutError: 'a + 2; - 3; perform: #yourself'.
	self assert: node isMessageCascadeNode.
	self assert: node receiver isIdentifierReferenceNode.
	self assert: node receiver name equals: #a.
	self assert: node messages size equals: 3.
]

{ #category : 'tests' }
SysmelParserTest >> testDictionary [
	| node |
	node := self parseSourceStringWithoutError: '#{First: 1}'.
	self assert: node isDictionaryNode.
	self assert: node elements size equals: 1.
]

{ #category : 'tests' }
SysmelParserTest >> testDictionary2 [
	| node |
	node := self parseSourceStringWithoutError: '#{First: 1. Second: 2}'.
	self assert: node isDictionaryNode.
	self assert: node elements size equals: 2.
]

{ #category : 'tests' }
SysmelParserTest >> testDictionary3 [
	| node |
	node := self parseSourceStringWithoutError: '#{First: 1. Second: 2. #Third : 3}'.
	self assert: node isDictionaryNode.
	self assert: node elements size equals: 3.
]

{ #category : 'tests' }
SysmelParserTest >> testEmpty [
	| ast |
	ast := self parseSourceStringWithoutError: ''.
	self assert: ast isSequenceNode.
]

{ #category : 'tests' }
SysmelParserTest >> testEmptyDictionary [
	| node |
	node := self parseSourceStringWithoutError: '#{}'.
	self assert: node isDictionaryNode.
	self assert: node elements size equals: 0.
]

{ #category : 'tests' }
SysmelParserTest >> testFunctionalType [
	| node |
	node := self parseSourceStringWithoutError: ':(Integer)x :: Integer'.
	self assert: node isFunctionalDependentTypeNode .
	self assert: node argumentPattern isBindableNameNode.

	self assert: node resultType isIdentifierReferenceNode.
	self assert: node resultType name equals: #Integer.
]

{ #category : 'tests' }
SysmelParserTest >> testIdentifierReference [
	| node |
	node := self parseSourceStringWithoutError: 'identifier'.
	self assert: node isIdentifierReferenceNode .
	self assert: node name equals: #identifier.
]

{ #category : 'tests' }
SysmelParserTest >> testKeywordApplication [
	| node |
	node := self parseSourceStringWithoutError: 'if: condition then: trueResult else: falseResult'.
	self assert: node isMessageSendNode .
	self assert: node receiver isNil.

	self assert: node selector isLiteralSymbolNode.
	self assert: node selector value equals: #if:then:else:.
	
	self assert: node arguments size equals: 3.
	self assert: node arguments first isIdentifierReferenceNode .
	self assert: node arguments first name equals: #condition.
	
	self assert: node arguments second isIdentifierReferenceNode .
	self assert: node arguments second name equals: #trueResult.

	self assert: node arguments third isIdentifierReferenceNode .
	self assert: node arguments third name equals: #falseResult.

]

{ #category : 'tests' }
SysmelParserTest >> testKeywordMessageSend [
	| node |
	node := self parseSourceStringWithoutError: 'a perform: #yourself'.
	self assert: node isMessageSendNode .
	self assert: node receiver isIdentifierReferenceNode.
	self assert: node receiver name equals: #a.

	self assert: node selector isLiteralSymbolNode.
	self assert: node selector value equals: #perform:.
	
	self assert: node arguments size equals: 1.
	self assert: node arguments first isLiteralSymbolNode.
	self assert: node arguments first value equals: #yourself.

]

{ #category : 'tests' }
SysmelParserTest >> testLexicalBlock [
	| node |
	node := self parseSourceStringWithoutError: '{42}'.
	self assert: node isLexicalBlockNode .
	self assert: node body isLiteralIntegerNode.
	self assert: node body value equals: 42.
]

{ #category : 'tests' }
SysmelParserTest >> testLiteralCharacter [
	| node |
	node := self parseSourceStringWithoutError: '''A'''.
	self assert: node isLiteralCharacterNode.
	self assert: node value equals: $A.
]

{ #category : 'tests' }
SysmelParserTest >> testLiteralFloat [
	| node |
	node := self parseSourceStringWithoutError: '42.5'.
	self assert: node isLiteralFloatNode.
	self assert: node value equals: 42.5.
	
	node := self parseSourceStringWithoutError: '42.5e3'.
	self assert: node isLiteralFloatNode.
	self assert: node value equals: 42.5e3.

]

{ #category : 'tests' }
SysmelParserTest >> testLiteralInteger [
	| node |
	node := self parseSourceStringWithoutError: '42'.
	self assert: node isLiteralIntegerNode.
	self assert: node value equals: 42.
	
	node := self parseSourceStringWithoutError: '2r1010'.
	self assert: node isLiteralIntegerNode.
	self assert: node value equals: 2r1010.

	node := self parseSourceStringWithoutError: '16rC0DE'.
	self assert: node isLiteralIntegerNode.
	self assert: node value equals: 16rC0DE.
]

{ #category : 'tests' }
SysmelParserTest >> testLiteralString [
	| node |
	node := self parseSourceStringWithoutError: '"Hello World"'.
	self assert: node isLiteralStringNode.
	self assert: node value equals: 'Hello World'.
	
	node := self parseSourceStringWithoutError: '"Hello \"World\""'.
	self assert: node isLiteralStringNode.
	self assert: node value equals: 'Hello "World"'.
]

{ #category : 'tests' }
SysmelParserTest >> testLiteralSymbolIdentifier [
	| node |
	node := self parseSourceStringWithoutError: '#symbol'.
	self assert: node isLiteralSymbolNode.
	self assert: node value equals: #symbol.
]

{ #category : 'tests' }
SysmelParserTest >> testLiteralSymbolKeyword [
	| node |
	node := self parseSourceStringWithoutError: '#symbol:'.
	self assert: node isLiteralSymbolNode.
	self assert: node value equals: #symbol: .
	
	node := self parseSourceStringWithoutError: '#symbol:with:'.
	self assert: node isLiteralSymbolNode.
	self assert: node value equals: #symbol:with: .
]

{ #category : 'tests' }
SysmelParserTest >> testLiteralSymbolString [
	| node |
	node := self parseSourceStringWithoutError: '#"Hello World"'.
	self assert: node isLiteralSymbolNode.
	self assert: node value equals: #'Hello World'.
	
	node := self parseSourceStringWithoutError: '#"Hello \"World\""'.
	self assert: node isLiteralSymbolNode.
	self assert: node value equals: #'Hello "World"'.
]

{ #category : 'tests' }
SysmelParserTest >> testQuasiQuote [
	| node |
	node := self parseSourceStringWithoutError: '``42'.
	self assert: node isQuasiQuoteNode.
	self assert: node term isLiteralIntegerNode.
	self assert: node term value equals: 42.

]

{ #category : 'tests' }
SysmelParserTest >> testQuasiUnquote [
	| node |
	node := self parseSourceStringWithoutError: '`,42'.
	self assert: node isQuasiUnquoteNode.
	self assert: node term isLiteralIntegerNode.
	self assert: node term value equals: 42.

]

{ #category : 'tests' }
SysmelParserTest >> testQuote [
	| node |
	node := self parseSourceStringWithoutError: '`''42'.
	self assert: node isQuoteNode.
	self assert: node term isLiteralIntegerNode.
	self assert: node term value equals: 42.

]

{ #category : 'tests' }
SysmelParserTest >> testSplice [
	| node |
	node := self parseSourceStringWithoutError: '`@42'.
	self assert: node isSpliceNode.
	self assert: node term isLiteralIntegerNode.
	self assert: node term value equals: 42.

]

{ #category : 'tests' }
SysmelParserTest >> testTuple [
	| node |
	node := self parseSourceStringWithoutError: '()'.
	self assert: node isTupleNode.
	self assert: node elements isEmpty.
	
]

{ #category : 'tests' }
SysmelParserTest >> testTuple1 [
	| node element |
	node := self parseSourceStringWithoutError: '42,'.
	self assert: node isTupleNode.
	self assert: node elements size equals: 1.
	
	element := node elements first.
	self assert: element isLiteralIntegerNode.
	self assert: element value equals: 42.
	 
	
]

{ #category : 'tests' }
SysmelParserTest >> testTuple2 [
	| node element |
	node := self parseSourceStringWithoutError: '42, 5'.
	self assert: node isTupleNode.
	self assert: node elements size equals: 2.
	
	element := node elements first.
	self assert: element isLiteralIntegerNode.
	self assert: element value equals: 42.
	 
	element := node elements second.
	self assert: element isLiteralIntegerNode.
	self assert: element value equals: 5.
	
]

{ #category : 'tests' }
SysmelParserTest >> testUnaryMessageSend [
	| node |
	node := self parseSourceStringWithoutError: 'a negated'.
	self assert: node isMessageSendNode .
	self assert: node receiver isIdentifierReferenceNode.
	self assert: node receiver name equals: #a.

	self assert: node selector isLiteralSymbolNode.
	self assert: node selector value equals: #negated
]
