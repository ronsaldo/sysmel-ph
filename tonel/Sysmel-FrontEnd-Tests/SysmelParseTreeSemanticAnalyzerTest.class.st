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
