"
I represent something which is done for its side-effects.
"
Class {
	#name : 'SysmelVoidType',
	#superclass : 'SysmelType',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelVoidType class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'testing' }
SysmelVoidType >> isVoid [
	^ true
]