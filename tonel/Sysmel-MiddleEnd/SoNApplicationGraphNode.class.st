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
SoNApplicationGraphNode >> arguments: aListOfArguments [
	arguments := aListOfArguments.
	aListOfArguments do: [ :each | each addUser: self ]
	
]

{ #category : 'as yet unclassified' }
SoNApplicationGraphNode >> dataDependenciesDo: aBlock [
	aBlock value: functional.
	arguments do: aBlock
]

{ #category : 'as yet unclassified' }
SoNApplicationGraphNode >> evaluateWithContext: evaluationContext [
	| evalFunctional evalArguments result |
	evalFunctional := evaluationContext getActivationValueForInstruction: functional. 
	evalArguments := evaluationContext getActivationValuesForInstructions: arguments.
	result := evalFunctional evaluateWithArguments: evalArguments.
	^ evaluationContext setValue: result andAdvancePC: 1
]

{ #category : 'accessing' }
SoNApplicationGraphNode >> functional [

	^ functional
]

{ #category : 'accessing' }
SoNApplicationGraphNode >> functional: aFunctionalObject [
	functional := aFunctionalObject.
	aFunctionalObject addUser: self
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
