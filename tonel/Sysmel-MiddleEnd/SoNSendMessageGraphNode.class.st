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

	arguments := anObject.
	arguments do: [ :each| each addUser: self ]
]

{ #category : 'as yet unclassified' }
SoNSendMessageGraphNode >> dataDependenciesDo: aBlock [
	aBlock value: receiver.
	aBlock value: selector.
	arguments do: aBlock.
]

{ #category : 'as yet unclassified' }
SoNSendMessageGraphNode >> evaluateWithContext: evaluationContext [
	| evalReceiver evalSelector evalArguments result |
	evalReceiver := evaluationContext evaluateNodeValue: receiver.
	evalSelector := evaluationContext evaluateNodeValue: selector.
	evalArguments := evaluationContext evaluateNodesValue: arguments.
	
	result := evalReceiver sysmelPerform: evalSelector withArguments: evalArguments.
	^ evaluationContext setValue: result andAdvancePC: 1
]

{ #category : 'testing' }
SoNSendMessageGraphNode >> isPinnedInstruction [
	^ true
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

	receiver := anObject.
	receiver addUser: self
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> selector [

	^ selector
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> selector: anObject [

	selector := anObject.
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNSendMessageGraphNode >> type: anObject [

	type := anObject
]
