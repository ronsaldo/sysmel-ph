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

{ #category : 'as yet unclassified' }
SoNDictionaryGraphNode >> dataDependenciesDo: aBlock [
	elements do: aBlock
]

{ #category : 'accessing' }
SoNDictionaryGraphNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SoNDictionaryGraphNode >> elements: aListOfElements [
	elements := aListOfElements.
	elements do: [ :each | each addUser: self ]
	
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
