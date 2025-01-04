Class {
	#name : 'SysmelScheduledRegionsAndInstructionsAlgorithm',
	#superclass : 'Object',
	#instVars : [
		'regions',
		'instructions',
		'enumeratedInstructions'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SysmelScheduledRegionsAndInstructionsAlgorithm >> enumeratedInstructions [
	enumeratedInstructions := OrderedCollection new.
	regions do: [ :eachRegion |
		eachRegion earlyInstructionSchedule do: [ :eachInstruction |
			enumeratedInstructions add: eachInstruction.
			eachInstruction index: enumeratedInstructions size.
		]
	].
	enumeratedInstructions do: [ :eachInstruction | eachInstruction setOwnerRegionIndex ].
	^ enumeratedInstructions
]

{ #category : 'as yet unclassified' }
SysmelScheduledRegionsAndInstructionsAlgorithm >> evaluateWithArguments: arguments [
	| evaluationContext result |
	evaluationContext := SysmelEvaluationContext new
		arguments: arguments;
		instructions: self enumeratedInstructions;
		pc: 1;
		yourself.
		
	^ result := evaluationContext run.
]

{ #category : 'accessing' }
SysmelScheduledRegionsAndInstructionsAlgorithm >> instructions [

	^ instructions
]

{ #category : 'accessing' }
SysmelScheduledRegionsAndInstructionsAlgorithm >> instructions: anObject [

	instructions := anObject
]

{ #category : 'accessing' }
SysmelScheduledRegionsAndInstructionsAlgorithm >> regions [

	^ regions
]

{ #category : 'accessing' }
SysmelScheduledRegionsAndInstructionsAlgorithm >> regions: anObject [

	regions := anObject
]
