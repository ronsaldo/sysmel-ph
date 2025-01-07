Class {
	#name : 'SysmelFunctionalAnalysisEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'argumentBindings',
		'captureBindings',
		'fixpointBinding'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
SysmelFunctionalAnalysisEnvironment >> captureBindings [
	^ captureBindings
]

{ #category : 'accessing' }
SysmelFunctionalAnalysisEnvironment >> fixpointBinding [
	^ fixpointBinding
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

{ #category : 'as yet unclassified' }
SysmelFunctionalAnalysisEnvironment >> withFixpointBinding: aFixpointBinding [
	fixpointBinding :=aFixpointBinding.
	
	aFixpointBinding name ifNotNil: [
		localSymbols at: aFixpointBinding name put: aFixpointBinding
	]
]
