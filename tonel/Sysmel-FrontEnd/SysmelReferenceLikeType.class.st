Class {
	#name : 'SysmelReferenceLikeType',
	#superclass : 'SysmelPointerLikeType',
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
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
