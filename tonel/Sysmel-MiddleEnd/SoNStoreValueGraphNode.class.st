Class {
	#name : 'SoNStoreValueGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'pointer',
		'value'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNStoreValueGraphNode >> dataDependenciesDo: aBlock [
	aBlock value: pointer.
	aBlock value: value.
]

{ #category : 'as yet unclassified' }
SoNStoreValueGraphNode >> evaluateWithContext: evaluationContext [
	| allocaBox newValue |
	allocaBox := evaluationContext getActivationValueForInstruction: pointer.
	newValue := evaluationContext getActivationValueForInstruction: value.
	allocaBox value: newValue.
	^ evaluationContext setValue: newValue andAdvancePC: 1
]

{ #category : 'testing' }
SoNStoreValueGraphNode >> isPinnedInstruction [
	^ true
]

{ #category : 'testing' }
SoNStoreValueGraphNode >> isStoreValueGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> pointer [

	^ pointer
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> pointer: anObject [

	pointer := anObject.
	pointer addUser: self
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> value [

	^ value
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> value: anObject [

	value := anObject.
	value addUser: self.
]
