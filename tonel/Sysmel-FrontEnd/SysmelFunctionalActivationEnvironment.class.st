Class {
	#name : 'SysmelFunctionalActivationEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'argumentValues'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
SysmelFunctionalActivationEnvironment >> argumentValues [

	^ argumentValues
]

{ #category : 'accessing' }
SysmelFunctionalActivationEnvironment >> argumentValues: anObject [

	argumentValues := anObject
]

{ #category : 'as yet unclassified' }
SysmelFunctionalActivationEnvironment >> getIndexedArgumentValue: index [
	^ argumentValues at: index
]
