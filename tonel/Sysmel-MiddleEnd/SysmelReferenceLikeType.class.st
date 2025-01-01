Class {
	#name : 'SysmelReferenceLikeType',
	#superclass : 'SysmelPointerLikeType',
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'converting' }
SysmelReferenceLikeType >> asDecayedSysmelType [
	^ baseType asDecayedSysmelType
]

{ #category : 'testing' }
SysmelReferenceLikeType >> isReferenceLikeType [
	^ true
]
