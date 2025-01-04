Class {
	#name : 'SoNLoadValueGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'pointer'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNLoadValueGraphNode >> dataDependenciesDo: aBlock [
	aBlock value: pointer
]

{ #category : 'as yet unclassified' }
SoNLoadValueGraphNode >> evaluateWithContext: evaluationContext [
	| allocaBox |
	allocaBox := evaluationContext getActivationValueForInstruction: pointer.
	^ evaluationContext setValue: allocaBox value andAdvancePC: 1
]

{ #category : 'testing' }
SoNLoadValueGraphNode >> isLoadValueGraphNode [
	^ true
]

{ #category : 'testing' }
SoNLoadValueGraphNode >> isPinnedInstruction [
	^ true
]

{ #category : 'accessing' }
SoNLoadValueGraphNode >> pointer [

	^ pointer
]

{ #category : 'accessing' }
SoNLoadValueGraphNode >> pointer: anObject [
	pointer := anObject.
	pointer addUser: self
]

{ #category : 'accessing' }
SoNLoadValueGraphNode >> type [
	^ pointer type baseType
]
