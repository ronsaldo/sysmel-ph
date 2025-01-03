Class {
	#name : 'SoNReturnNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'value',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNReturnNode >> dataDependenciesDo: aBlock [
	value ifNotNil: [ aBlock value: value ]
]

{ #category : 'testing' }
SoNReturnNode >> isBasicBlockTerminator [
	^ true
]

{ #category : 'testing' }
SoNReturnNode >> isPinnedInstruction [
	^ true
]

{ #category : 'accessing' }
SoNReturnNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNReturnNode >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
SoNReturnNode >> value [

	^ value
]

{ #category : 'accessing' }
SoNReturnNode >> value: anObject [
	value := anObject.
	value ifNotNil: [ value addUser: self ]
]
