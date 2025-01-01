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

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> destination [

	^ destination
]

{ #category : 'accessing' }
SoNPhiCopyGraphNode >> destination: anObject [

	destination := anObject
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

	value := anObject
]
