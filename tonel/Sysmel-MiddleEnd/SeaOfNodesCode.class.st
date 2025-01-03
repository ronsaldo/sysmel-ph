"
I am used for encapsulating Sea of Nodes code.
"
Class {
	#name : 'SeaOfNodesCode',
	#superclass : 'Object',
	#instVars : [
		'startingRegion',
		'endingRegions',
		'instructionSchedule'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SeaOfNodesCode >> endingRegions [

	^ endingRegions
]

{ #category : 'accessing' }
SeaOfNodesCode >> endingRegions: anObject [
	endingRegions := anObject
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> evaluate [
	^ instructionSchedule evaluateWithArguments: #()
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> findDataDependencies [
	| visitedSet |
	visitedSet := Set new.
	
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> instructionSchedule [
	^ instructionSchedule
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> scheduleAndEvaluate [
	self scheduleInstructions.
	^ self evaluate
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> scheduleInstructions [
	^ instructionSchedule ifNil: [
		instructionSchedule := SysmelGlobalCodeMotionAlgorithm new runOn: self
	]
	
]

{ #category : 'accessing' }
SeaOfNodesCode >> startingRegion [

	^ startingRegion
]

{ #category : 'accessing' }
SeaOfNodesCode >> startingRegion: anObject [

	startingRegion := anObject
]
