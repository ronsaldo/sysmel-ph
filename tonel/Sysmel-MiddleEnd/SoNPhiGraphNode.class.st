Class {
	#name : 'SoNPhiGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNPhiGraphNode >> evaluateWithContext: evaluationContext [
	^ evaluationContext advancePC: 1
]

{ #category : 'testing' }
SoNPhiGraphNode >> isPhiGraphNode [
	^ true
]

{ #category : 'testing' }
SoNPhiGraphNode >> isPinnedInstruction [
	^ true
]

{ #category : 'accessing' }
SoNPhiGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNPhiGraphNode >> type: anObject [

	type := anObject
]
