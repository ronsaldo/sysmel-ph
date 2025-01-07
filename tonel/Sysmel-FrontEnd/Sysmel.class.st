Class {
	#name : 'Sysmel',
	#superclass : 'Object',
	#instVars : [
		'module'
	],
	#category : 'Sysmel-FrontEnd',
	#package : 'Sysmel-FrontEnd'
}

{ #category : 'as yet unclassified' }
Sysmel class >> moduleNamed: aModuleName [
	^ self new moduleNamed: aModuleName
]

{ #category : 'as yet unclassified' }
Sysmel >> moduleNamed: aModuleName [
	module := SysmelModule named: aModuleName.
	module sysmelFrontEnd: self
]

{ #category : 'parsing' }
Sysmel >> parseAndCompileSourceCode: sourceCode [
	| ast environment topLevelSeaOfNode asg |
	ast := SysmelParser new parseSourceCode: sourceCode.
	environment := module makeEnvironmentFor: ast.
	
	asg := SysmelParseTreeSemanticAnalyzer new
			analyzeAST: ast withEnvironment: environment.
	^ asg
]

{ #category : 'parsing' }
Sysmel >> parseAndCompileString: sourceString [
	| sourceCode |
	sourceCode := SysmelSourceCode new
		text: sourceString;
		yourself.
	^ self parseAndCompileSourceCode: sourceCode
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateFile: aFileReference [
	^self parseAndEvaluateSourceCode: (SysmelSourceCode new
			language: #sysmel;
			directory: aFileReference parent canonicalize fullName ;
			name: aFileReference basename;
			text: aFileReference contents;
			yourself)
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateModule: aFileReference [
	| moduleStartingSource |
	self assert: aFileReference isDirectory.
	moduleStartingSource := aFileReference / 'module.sysmel'.
	moduleStartingSource exists ifFalse: [ self error: 'Module is missing the module.sysmel entry point.' ].
	self parseAndEvaluateFile: moduleStartingSource
	
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateSourceCode: sourceCode [
	| ast environment typedASG |
	ast := SysmelParser new parseSourceCode: sourceCode.
	environment := module makeEnvironmentFor: ast.
	
	typedASG := SysmelParseTreeSemanticAnalyzer new
			analyzeAST: ast withEnvironment: environment.
	^ SysmelTypedGraphNodeEvaluator new
		evaluateASG: typedASG
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateString: sourceString [
	| sourceCode |
	sourceCode := SysmelSourceCode new
		text: sourceString;
		yourself.
	^ self parseAndEvaluateSourceCode: sourceCode
]
