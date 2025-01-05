Class {
	#name : 'SoNTupleGraphNode',
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
SoNTupleGraphNode >> dataDependenciesDo: aBlock [
	elements do: aBlock
]

{ #category : 'accessing' }
SoNTupleGraphNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SoNTupleGraphNode >> elements: anObject [

	elements := anObject.
	elements do: [ :each | each addUser: self ]
]

{ #category : 'as yet unclassified' }
SoNTupleGraphNode >> evaluateWithContext: evaluationContext [
	| tuple |
	tuple := evaluationContext getActivationValuesForInstructions: elements.
	^ evaluationContext setValue: tuple andAdvancePC: 1
]

{ #category : 'testing' }
SoNTupleGraphNode >> hasDictionaryAsInput: aBoolean [
	"Do nothing here."
]

{ #category : 'testing' }
SoNTupleGraphNode >> isTupleGraphNode [
	^ true
]

{ #category : 'as yet unclassified' }
SoNTupleGraphNode >> processConstructionElements [
	"Nothing is required here."
]

{ #category : 'accessing' }
SoNTupleGraphNode >> type [
	^ type
]

{ #category : 'accessing' }
SoNTupleGraphNode >> type: anObject [

	type := anObject
]
