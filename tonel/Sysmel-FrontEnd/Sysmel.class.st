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
Sysmel >> moduleNamed: aModuleNamed [
	module := SysmelModule named: #Testing
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateFile: aFileReference [
	self halt.
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateSourceCode: sourceCode [
	| ast environment astAndRegion |
	ast := SysmelParser new parseSourceCode: sourceCode.
	environment := module makeEnvironmentFor: ast.
	
	astAndRegion := SysmelParseTreeSemanticAnalyzer new
			analyzeAST: ast withEnvironment: environment region: SoNRegionGraphNode new.
	^ astAndRegion
]

{ #category : 'parsing' }
Sysmel >> parseAndEvaluateString: sourceString [
	| sourceCode |
	sourceCode := SysmelSourceCode new
		text: sourceString;
		yourself.
	^ self parseAndEvaluateSourceCode: sourceCode
]
