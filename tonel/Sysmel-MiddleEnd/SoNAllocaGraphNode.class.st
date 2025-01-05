Class {
	#name : 'SoNAllocaGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'valueType',
		'type',
		'exportableName'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'converting' }
SoNAllocaGraphNode >> asAllocaBoxOrPointer [
	^ self
]

{ #category : 'as yet unclassified' }
SoNAllocaGraphNode >> evaluateWithContext: evaluationContext [
	| allocaBox |
	allocaBox := SoNAllocaBox new.
	^ evaluationContext setValue: allocaBox andAdvancePC: 1
]

{ #category : 'accessing' }
SoNAllocaGraphNode >> exportableName [

	^ exportableName
]

{ #category : 'accessing' }
SoNAllocaGraphNode >> exportableName: anObject [

	exportableName := anObject
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
