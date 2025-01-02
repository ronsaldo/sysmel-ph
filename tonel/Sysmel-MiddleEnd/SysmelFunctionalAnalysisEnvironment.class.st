Class {
	#name : 'SysmelFunctionalAnalysisEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'argumentBindings',
		'captureBindings'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
SysmelFunctionalAnalysisEnvironment >> captureBindings [
	^ captureBindings
]

{ #category : 'initialization' }
SysmelFunctionalAnalysisEnvironment >> initialize [
	super initialize.
	argumentBindings := OrderedCollection new.
	captureBindings := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
SysmelFunctionalAnalysisEnvironment >> withArgumentBinding: anArgumentBinding [
	argumentBindings add: anArgumentBinding.
	
	anArgumentBinding name ifNotNil: [
		localSymbols at: anArgumentBinding name put: anArgumentBinding
	]
]
