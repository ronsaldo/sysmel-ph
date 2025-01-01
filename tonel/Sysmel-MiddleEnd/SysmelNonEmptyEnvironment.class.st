Class {
	#name : 'SysmelNonEmptyEnvironment',
	#superclass : 'AbstractSysmelEnvironment',
	#instVars : [
		'parent',
		'localSymbol'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
SysmelNonEmptyEnvironment class >> parent: aParentEnvironment [
	^ self new parent: aParentEnvironment; yourself
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> parent [

	^ parent
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> parent: anObject [

	parent := anObject
]
