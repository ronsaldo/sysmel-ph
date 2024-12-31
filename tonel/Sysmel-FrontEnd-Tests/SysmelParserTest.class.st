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
SysmelParserTest >> testEmpty [
	| ast |
	ast := self parseSourceStringWithoutError: ''.
	self assert: ast isSequenceNode.
]
