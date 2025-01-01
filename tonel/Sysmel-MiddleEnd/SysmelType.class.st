Class {
	#name : 'SysmelType',
	#superclass : 'SysmelProgramEntity',
	#instVars : [
		'sourcePosition',
		'optionalName'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'converting' }
SysmelType >> asDecayedSysmelType [
	^ self
]

{ #category : 'testing' }
SysmelType >> isPointerLikeType [
	^ false
]

{ #category : 'testing' }
SysmelType >> isReferenceLikeType [
	^ false
]

{ #category : 'testing' }
SysmelType >> isValidSysmelType [
	^ true
]

{ #category : 'testing' }
SysmelType >> isVoid [
	^ false
]

{ #category : 'accessing' }
SysmelType >> optionalName [

	^ optionalName
]

{ #category : 'accessing' }
SysmelType >> optionalName: anObject [

	optionalName := anObject
]

{ #category : 'accessing' }
SysmelType >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelType >> sourcePosition: anObject [

	sourcePosition := anObject
]
