Class {
	#name : 'SoNDictionaryGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNDictionaryGraphNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SoNDictionaryGraphNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SoNDictionaryGraphNode >> isDictionaryGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNDictionaryGraphNode >> type [
	self flag: 'Use something better'.
	^ SysmelTypeGradual uniqueInstance
]
