Class {
	#name : 'SoNAssociationGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'key',
		'value',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNAssociationGraphNode >> dataDependenciesDo: aBlock [
	aBlock value: key.
	value ifNotNil: [ aBlock value: key ]
]

{ #category : 'testing' }
SoNAssociationGraphNode >> isAssociationGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNAssociationGraphNode >> key [

	^ key
]

{ #category : 'accessing' }
SoNAssociationGraphNode >> key: anObject [

	key := anObject.
	key addUser: self
]

{ #category : 'accessing' }
SoNAssociationGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNAssociationGraphNode >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
SoNAssociationGraphNode >> value [

	^ value
]

{ #category : 'accessing' }
SoNAssociationGraphNode >> value: anObject [

	value := anObject.
	value addUser: self
]
