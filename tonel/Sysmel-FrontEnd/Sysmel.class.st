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
	module := SysmelModule named: aModuleName
]

{ #category : 'parsing' }
Sysmel >> parseAndCompileSourceCode: sourceCode [
	| ast environment topLevelSeaOfNode |
	ast := SysmelParser new parseSourceCode: sourceCode.
	environment := module makeEnvironmentFor: ast.
	
	topLevelSeaOfNode := SysmelParseTreeSemanticAnalyzer new
			analyzeAST: ast withEnvironment: environment region: (SoNRegionGraphNode new name: #entry; yourself).
	^ topLevelSeaOfNode scheduleInstructions
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
	self assert: aFileReference isDirectory.
	self halt
	
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateSourceCode: sourceCode [
	| ast environment topLevelSeaOfNode |
	ast := SysmelParser new parseSourceCode: sourceCode.
	environment := module makeEnvironmentFor: ast.
	
	topLevelSeaOfNode := SysmelParseTreeSemanticAnalyzer new
			analyzeAST: ast withEnvironment: environment region: (SoNRegionGraphNode new name: #entry; yourself).
	^ topLevelSeaOfNode scheduleAndEvaluate
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateString: sourceString [
	| sourceCode |
	sourceCode := SysmelSourceCode new
		text: sourceString;
		yourself.
	^ self parseAndEvaluateSourceCode: sourceCode
]
