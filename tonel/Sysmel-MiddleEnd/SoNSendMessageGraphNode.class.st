Class {
	#name : 'SoNSendMessageGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'receiver',
		'selector',
		'arguments',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNSendMessageGraphNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'as yet unclassified' }
SoNSendMessageGraphNode >> dataDependencies [
	^ {receiver . selector} , arguments 
]

{ #category : 'testing' }
SoNSendMessageGraphNode >> isSendMessageGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> receiver [

	^ receiver
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> selector [

	^ selector
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> selector: anObject [

	selector := anObject
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> type: anObject [

	type := anObject
]
