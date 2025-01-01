Class {
	#name : 'SoNGraphNode',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'testing' }
SoNGraphNode >> isSequencingGraphNode [
	^ false
]

{ #category : 'accessing' }
SoNGraphNode >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SoNGraphNode >> sourcePosition: anObject [

	sourcePosition := anObject
]

{ #category : 'accessing' }
SoNGraphNode >> type [
	^ self subclassResponsibility
]
