Class {
	#name : 'SoNStructGraphNode',
	#superclass : 'SoNTupleGraphNode',
	#instVars : [
		'elementIndices'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNStructGraphNode >> evaluateWithContext: evaluationContext [
	| struct constructorArgs structInstance |
	constructorArgs := evaluationContext getActivationValuesForInstructions: elements.
	structInstance := type makePrimitiveAt: sourcePosition constructorArguments: constructorArgs.
	^ evaluationContext setValue: structInstance andAdvancePC: 1
]

{ #category : 'as yet unclassified' }
SoNStructGraphNode >> hasDictionaryAsInput: aBoolean [
	| dictionary |
	aBoolean ifFalse: [ ^ self ].
	self assert: elements first isDictionaryGraphNode.
	dictionary := elements first.
	elements := type elements collect: [ :eachElement | eachElement defaultValue ].
	dictionary elements do: [ :eachAssociation |
		| fieldName fieldValue fieldIndex |
		fieldName := eachAssociation key value.
		fieldValue := eachAssociation value.
		fieldIndex := type nameToIndex: fieldName.
		fieldIndex ifNil: [
			self error: ('Failed to find index for field {1} in {2}.' format: { fieldName. type printString }) 
		].
		
		elements at: fieldIndex put: fieldValue
	].
	
]

{ #category : 'as yet unclassified' }
SoNStructGraphNode >> processConstructionElements [
	"Handle the dictionary input case."
]
