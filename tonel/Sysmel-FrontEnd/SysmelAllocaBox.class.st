Class {
	#name : 'SysmelAllocaBox',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition',
		'valueType',
		'type',
		'currentValue'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'accessing' }
SysmelAllocaBox >> currentValue [

	^ currentValue
]

{ #category : 'accessing' }
SysmelAllocaBox >> currentValue: anObject [

	currentValue := anObject
]

{ #category : 'printing' }
SysmelAllocaBox >> printOn: aStream [
	aStream nextPut: $[; print: currentValue; nextPut: $]
]

{ #category : 'accessing' }
SysmelAllocaBox >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelAllocaBox >> sourcePosition: anObject [

	sourcePosition := anObject
]

{ #category : 'accessing' }
SysmelAllocaBox >> type [

	^ type
]

{ #category : 'accessing' }
SysmelAllocaBox >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
SysmelAllocaBox >> valueType [

	^ valueType
]

{ #category : 'accessing' }
SysmelAllocaBox >> valueType: anObject [

	valueType := anObject
]
