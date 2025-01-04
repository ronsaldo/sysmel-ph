Class {
	#name : 'SoNLambdaNode',
	#superclass : 'SoNTypedFunctionalNode',
	#instVars : [
		'seaOfNodesCode'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNLambdaNode >> evaluateWithArguments: evalArguments [
	| scheduledLambdaInstructions result |
	scheduledLambdaInstructions := seaOfNodesCode scheduleInstructions.
	^ scheduledLambdaInstructions evaluateWithArguments: evalArguments.
]

{ #category : 'as yet unclassified' }
SoNLambdaNode >> evaluateWithContext: evaluationContext [
	^ evaluationContext setValue: self andAdvancePC: 1
]

{ #category : 'testing' }
SoNLambdaNode >> isLambdaNode [
	^ true
]

{ #category : 'accessing' }
SoNLambdaNode >> seaOfNodesCode [

	^ seaOfNodesCode
]

{ #category : 'accessing' }
SoNLambdaNode >> seaOfNodesCode: anObject [

	seaOfNodesCode := anObject
]
