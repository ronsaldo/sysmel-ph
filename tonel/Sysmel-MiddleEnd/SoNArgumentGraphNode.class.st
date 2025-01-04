Class {
	#name : 'SoNArgumentGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'type',
		'binding',
		'isImplicit',
		'isExistential'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNArgumentGraphNode >> binding [

	^ binding
]

{ #category : 'accessing' }
SoNArgumentGraphNode >> binding: anObject [

	binding := anObject
]

{ #category : 'as yet unclassified' }
SoNArgumentGraphNode >> evaluateWithContext: evaluationContext [
	| argumentValue |
	argumentValue := evaluationContext arguments at: self binding index.
	^ evaluationContext setValue: argumentValue andAdvancePC: 1
]

{ #category : 'initialization' }
SoNArgumentGraphNode >> initialize [
	^ super initialize.
	isImplicit := false.
	isExistential := false.
]

{ #category : 'accessing' }
SoNArgumentGraphNode >> isExistential [

	^ isExistential
]

{ #category : 'accessing' }
SoNArgumentGraphNode >> isExistential: anObject [

	isExistential := anObject
]

{ #category : 'accessing' }
SoNArgumentGraphNode >> isImplicit [

	^ isImplicit
]

{ #category : 'accessing' }
SoNArgumentGraphNode >> isImplicit: anObject [

	isImplicit := anObject
]

{ #category : 'accessing' }
SoNArgumentGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNArgumentGraphNode >> type: anObject [

	type := anObject
]
