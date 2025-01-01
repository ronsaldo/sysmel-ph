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

{ #category : 'testing' }
SoNLoadValueGraphNode >> isLoadValueGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNLoadValueGraphNode >> pointer [

	^ pointer
]

{ #category : 'accessing' }
SoNLoadValueGraphNode >> pointer: anObject [

	pointer := anObject
]

{ #category : 'accessing' }
SoNLoadValueGraphNode >> type [
	^ pointer type baseType
]
