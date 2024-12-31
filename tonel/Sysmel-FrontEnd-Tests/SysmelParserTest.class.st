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
	self assert: node functional value equals: #a.
]

{ #category : 'tests' }
SysmelParserTest >> testApplication2 [
	| node |
	node := self parseSourceStringWithoutError: 'a(42)'.
	self assert: node isApplicationNode.
	self assert: node functional isIdentifierReferenceNode.
	self assert: node functional value equals: #a.
	
	self assert: node arguments size equals: 1.
	self assert: node arguments first isLiteralIntegerNode.
	self assert: node arguments first isLiteralIntegerNode equals: 42
	
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
	
	operator2 := node elements at: 4.
	self assert: operator2 isLiteralSymbolNode.
	self assert: operator2 value equals: #*.

	rightOperand2 := node elements at: 5.
	self assert: rightOperand2 isLiteralIntegerNode.
	self assert: rightOperand2 value equals: 5
]

{ #category : 'tests' }
SysmelParserTest >> testEmpty [
	| ast |
	ast := self parseSourceStringWithoutError: ''.
	self assert: ast isSequenceNode.
]

{ #category : 'tests' }
SysmelParserTest >> testIdentifierReference [
	| node |
	node := self parseSourceStringWithoutError: 'identifier'.
	self assert: node isIdentifierReferenceNode .
	self assert: node name equals: #identifier.
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
	self assert: element equals: 42.
	 
	
]

{ #category : 'tests' }
SysmelParserTest >> testTuple2 [
	| node element |
	node := self parseSourceStringWithoutError: '42, 5'.
	self assert: node isTupleNode.
	self assert: node elements size equals: 2.
	
	element := node elements first.
	self assert: element isLiteralIntegerNode.
	self assert: element equals: 42.
	 
	element := node elements second.
	self assert: element isLiteralIntegerNode.
	self assert: element equals: 5.
	
]
