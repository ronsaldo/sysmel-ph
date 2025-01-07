Class {
	#name : 'SysmelPointerType',
	#superclass : 'SysmelPointerLikeType',
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'as yet unclassified' }
SysmelPointerType >> supportsSelector: aSelector [
	^ #(value _) includes: aSelector
]
