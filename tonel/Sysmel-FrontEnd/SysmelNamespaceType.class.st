Class {
	#name : 'SysmelNamespaceType',
	#superclass : 'SysmelType',
	#classInstVars : [
		'singleton'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'instance creation' }
SysmelNamespaceType class >> uniqueInstance [
	^ singleton ifNil: [ singleton := self new ]
]
