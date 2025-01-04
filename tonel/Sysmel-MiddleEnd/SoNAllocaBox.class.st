Class {
	#name : 'SoNAllocaBox',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNAllocaBox >> loadValueFromMemory [
	^ value
]

{ #category : 'as yet unclassified' }
SoNAllocaBox >> storeValueIntoMemory: newValue [
	^ value := newValue
]

{ #category : 'accessing' }
SoNAllocaBox >> value [

	^ value
]

{ #category : 'accessing' }
SoNAllocaBox >> value: anObject [

	value := anObject
]
