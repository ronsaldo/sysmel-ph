Class {
	#name : 'SoNTupleGraphNode',
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
SoNTupleGraphNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SoNTupleGraphNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SoNTupleGraphNode >> isTupleGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNTupleGraphNode >> type [
	^ type
]

{ #category : 'accessing' }
SoNTupleGraphNode >> type: anObject [

	type := anObject
]