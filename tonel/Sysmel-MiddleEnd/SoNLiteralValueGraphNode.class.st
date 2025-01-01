Class {
	#name : 'SoNLiteralValueGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'value',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'testing' }
SoNLiteralValueGraphNode >> isLiteralValueGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> value [

	^ value
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> value: anObject [

	value := anObject
]
