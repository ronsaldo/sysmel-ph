Class {
	#name : 'SysmelTypeGradual',
	#superclass : 'SysmelType',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelTypeGradual class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'testing' }
SysmelTypeGradual >> isGradualType [
	^ true
]

{ #category : 'accessing' }
SysmelTypeGradual >> type [
	^ self
]
