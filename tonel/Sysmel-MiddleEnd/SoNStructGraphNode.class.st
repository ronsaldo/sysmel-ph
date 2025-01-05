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
SoNStructGraphNode >> processConstructionElements [
	"Handle the dictionary input case."
]
