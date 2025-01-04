Class {
	#name : 'SysmelNamespaceType',
	#superclass : 'SysmelType',
	#classInstVars : [
		'singleton'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'instance creation' }
SysmelNamespaceType class >> uniqueInstance [
	^ singleton ifNil: [ singleton := self new ]
]
