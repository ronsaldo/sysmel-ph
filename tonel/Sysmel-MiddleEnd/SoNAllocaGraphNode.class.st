Class {
	#name : 'SoNAllocaGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'valueType',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNAllocaGraphNode >> evaluateWithContext: evaluationContext [
	| allocaBox |
	allocaBox := SoNAllocaBox new.
	^ evaluationContext setValue: allocaBox andAdvancePC: 1
]

{ #category : 'testing' }
SoNAllocaGraphNode >> isAllocaGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNAllocaGraphNode >> type [
	^ type
]

{ #category : 'accessing' }
SoNAllocaGraphNode >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
SoNAllocaGraphNode >> valueType [

	^ valueType
]

{ #category : 'accessing' }
SoNAllocaGraphNode >> valueType: anObject [

	valueType := anObject
]
