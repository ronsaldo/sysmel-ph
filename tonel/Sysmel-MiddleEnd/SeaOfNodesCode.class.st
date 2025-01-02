"
I am used for encapsulating Sea of Nodes code.
"
Class {
	#name : 'SeaOfNodesCode',
	#superclass : 'Object',
	#instVars : [
		'dataResult',
		'startingRegion'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SeaOfNodesCode >> dataResult [

	^ dataResult
]

{ #category : 'accessing' }
SeaOfNodesCode >> dataResult: anObject [

	dataResult := anObject
]

{ #category : 'accessing' }
SeaOfNodesCode >> startingRegion [

	^ startingRegion
]

{ #category : 'accessing' }
SeaOfNodesCode >> startingRegion: anObject [

	startingRegion := anObject
]
