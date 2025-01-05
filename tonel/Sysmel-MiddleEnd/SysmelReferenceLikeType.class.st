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

{ #category : 'as yet unclassified' }
SysmelReferenceLikeType >> supportsSelector: aSelector [
	^ #(address) includes: aSelector
]
