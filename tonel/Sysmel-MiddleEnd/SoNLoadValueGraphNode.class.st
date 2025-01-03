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

{ #category : 'as yet unclassified' }
SoNLoadValueGraphNode >> dataDependencies [
	^ pointer
]

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
	pointer := anObject.
	pointer addUser: self
]

{ #category : 'accessing' }
SoNLoadValueGraphNode >> type [
	^ pointer type baseType
]
