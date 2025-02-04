"
I represent something which is done for its side-effects.
"
Class {
	#name : 'SysmelVoidType',
	#superclass : 'SysmelType',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'testing' }
SysmelVoidType class >> isVoidType [
	^ true
]

{ #category : 'accessing' }
SysmelVoidType class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'testing' }
SysmelVoidType >> isVoid [
	^ true
]

{ #category : 'printing' }
SysmelVoidType >> printOn: aStream [
	aStream nextPutAll: 'void'
]
