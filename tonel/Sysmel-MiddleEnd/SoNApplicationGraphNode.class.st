Class {
	#name : 'SoNApplicationGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'functional',
		'arguments',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNApplicationGraphNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SoNApplicationGraphNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SoNApplicationGraphNode >> functional [

	^ functional
]

{ #category : 'accessing' }
SoNApplicationGraphNode >> functional: anObject [

	functional := anObject
]

{ #category : 'testing' }
SoNApplicationGraphNode >> isApplicationGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNApplicationGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNApplicationGraphNode >> type: anObject [

	type := anObject
]
