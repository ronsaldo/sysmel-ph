Class {
	#name : 'SysmelNonEmptyEnvironment',
	#superclass : 'AbstractSysmelEnvironment',
	#instVars : [
		'sourcePosition',
		'parent',
		'localSymbols'
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
SysmelNonEmptyEnvironment >> localSymbols [

	^ localSymbols
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> localSymbols: anObject [

	localSymbols := anObject
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> parent [

	^ parent
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> parent: anObject [

	parent := anObject
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> sourcePosition: anObject [

	sourcePosition := anObject
]
