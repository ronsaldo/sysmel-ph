Class {
	#name : 'SoNSequencingGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'elements',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNSequencingGraphNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SoNSequencingGraphNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SoNSequencingGraphNode >> isSequencingGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNSequencingGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNSequencingGraphNode >> type: anObject [

	type := anObject
]
