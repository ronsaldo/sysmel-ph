Class {
	#name : 'SysmelPointerType',
	#superclass : 'SysmelPointerLikeType',
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'as yet unclassified' }
SysmelPointerType >> supportsSelector: aSelector [
	^ #(value _) includes: aSelector
]
