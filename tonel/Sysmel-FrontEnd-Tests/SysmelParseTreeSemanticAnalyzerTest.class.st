"
A SysmelParseTreeSemanticAnalyzerTest is a test class for testing the behavior of SysmelParseTreeSemanticAnalyzer
"
Class {
	#name : 'SysmelParseTreeSemanticAnalyzerTest',
	#superclass : 'TestCase',
	#instVars : [
		'module'
	],
	#category : 'Sysmel-FrontEnd-Tests-Analysis',
	#package : 'Sysmel-FrontEnd-Tests',
	#tag : 'Analysis'
}

{ #category : 'parsing' }
SysmelParseTreeSemanticAnalyzerTest >> parseAndAnalyse: sourceString [
	| ast environment |
	ast := self parseSourceStringWithoutError: sourceString.
	environment := module makeEnvironmentFor: ast.

	^ SysmelParseTreeSemanticAnalyzer new
			analyzeAST: ast withEnvironment: environment
]

{ #category : 'parsing' }
SysmelParseTreeSemanticAnalyzerTest >> parseSourceString: sourceString [
	| sourceCode |
	sourceCode := SysmelSourceCode new
		text: sourceString;
		yourself.
	^ SysmelParser new parseSourceCode: sourceCode
]

{ #category : 'parsing' }
SysmelParseTreeSemanticAnalyzerTest >> parseSourceStringWithoutError: string [
	| ast |
	ast := self parseSourceString: string.
	self assert: (SysmelParseTreeErrorVisitor new checkAndPrintErrors: ast).
	^ ast
]

{ #category : 'running' }
SysmelParseTreeSemanticAnalyzerTest >> setUp [
	module := SysmelModule named: #Testing.
	
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testEmpty [
	| asg |
	asg := self parseAndAnalyse: ''.
	self assert: asg isSequencingGraphNode.
	self assert: asg elements isEmpty.
	self assert: asg type isVoid.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testIntrinsicIdentifierReference [ 
	| asg |
	asg := self parseAndAnalyse: 'Object'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: Object.
	self assert: asg type equals: Object class.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLexicalBlock [ 
	| asg |
	asg := self parseAndAnalyse: '{42}'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 42.
	self assert: asg type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralCharacter [ 
	| asg |
	asg := self parseAndAnalyse: '''A'''.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: $A.
	self assert: asg type equals: Character.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralFloat [
	| asg |
	asg := self parseAndAnalyse: '42.5'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 42.5.
	self assert: asg type equals: Float.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralInteger [
	| asg |
	asg := self parseAndAnalyse: '42'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 42.
	self assert: asg type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralInteger2 [
	| asg |
	asg := self parseAndAnalyse: '42. 5'.
	self assert: asg isSequencingGraphNode.
	self assert: asg elements size equals: 2.
	
	self assert: asg elements first value equals: 42.
	self assert: asg elements first type equals: Integer.
	
	self assert: asg elements second value equals: 5.
	self assert: asg elements second type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralString [
	| asg |
	asg := self parseAndAnalyse: '"Hello World"'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 'Hello World'.
	self assert: asg type equals: String.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralSymbol [
	| asg |
	asg := self parseAndAnalyse: '#helloSymbol'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: #helloSymbol.
	self assert: asg type equals: Symbol.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple [
	| asg |
	asg := self parseAndAnalyse: '()'.
	self assert: asg isTupleGraphNode.
	self assert: asg elements size equals: 0
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple1 [
	| asg |
	asg := self parseAndAnalyse: '42,'.
	self assert: asg isTupleGraphNode.
	self assert: asg elements size equals: 1
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple2 [
	| asg |
	asg := self parseAndAnalyse: '42, 5'.
	self assert: asg isTupleGraphNode.
	self assert: asg elements size equals: 2
]
