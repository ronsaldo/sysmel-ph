Class {
	#name : 'SoNSequencingGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'elements',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNSequencingGraphNode >> dataDependenciesDo: aBlock [
	elements do: aBlock
]

{ #category : 'accessing' }
SoNSequencingGraphNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SoNSequencingGraphNode >> elements: anObject [

	elements := anObject.
	elements do: [ :each | each addUser: self ]
]

{ #category : 'as yet unclassified' }
SoNSequencingGraphNode >> evaluateWithContext: evaluationContext [
	| result |
	result := elements
		ifEmpty: [ nil ]
		ifNotEmpty: [ evaluationContext getActivationValueForInstruction: elements last ].
	^ evaluationContext setValue: result andAdvancePC: 1
]

{ #category : 'as yet unclassified' }
SoNSequencingGraphNode >> findAllExportableObjects [
	| foundObjects |
	foundObjects := OrderedCollection new.
	elements do: [ :each |
		foundObjects addAll: each findAllExportableObjects
	].
	^ foundObjects
]

{ #category : 'testing' }
SoNSequencingGraphNode >> isSequencingGraphNode [
	^ true
]

{ #category : 'accessing' }
SoNSequencingGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNSequencingGraphNode >> type: anObject [

	type := anObject
]
