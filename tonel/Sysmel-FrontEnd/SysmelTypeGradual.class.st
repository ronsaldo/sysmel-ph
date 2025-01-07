Class {
	#name : 'SysmelTypeGradual',
	#superclass : 'SysmelType',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelTypeGradual class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
SysmelTypeGradual >> defaultValue [
	^ nil
]

{ #category : 'testing' }
SysmelTypeGradual >> isGradualType [
	^ true
]

{ #category : 'accessing' }
SysmelTypeGradual >> type [
	^ self
]
