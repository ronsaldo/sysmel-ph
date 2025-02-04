Class {
	#name : 'SoNPhiCopyGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'value',
		'type',
		'destination'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNPhiCopyGraphNode >> dataDependenciesDo: aBlock [
	aBlock value: value.
]

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> destination [

	^ destination
]

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> destination: anObject [

	destination := anObject.
	destination addUser: self
]

{ #category : 'as yet unclassified' }
SoNPhiCopyGraphNode >> evaluateWithContext: evaluationContext [
	| phiValue |
	phiValue := evaluationContext getActivationValueForInstruction: value.
	evaluationContext setValue: phiValue inIndex: destination index.
	^ evaluationContext setValue: phiValue value andAdvancePC: 1
]

{ #category : 'testing' }
SoNPhiCopyGraphNode >> isPhiCopyGraphNode [
	^ false
]

{ #category : 'testing' }
SoNPhiCopyGraphNode >> isPinnedInstruction [
	^ true
]

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> value [

	^ value
]

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> value: anObject [

	value := anObject.
	value addUser: self
]
