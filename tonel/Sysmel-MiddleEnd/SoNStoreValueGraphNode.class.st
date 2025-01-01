Class {
	#name : 'SoNStoreValueGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'pointer',
		'value'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNStoreValueGraphNode >> pointer [

	^ pointer
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> pointer: anObject [

	pointer := anObject
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> value [

	^ value
]

{ #category : 'accessing' }
SoNStoreValueGraphNode >> value: anObject [

	value := anObject
]
