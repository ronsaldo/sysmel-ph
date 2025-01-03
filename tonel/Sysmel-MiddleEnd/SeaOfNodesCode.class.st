"
I am used for encapsulating Sea of Nodes code.
"
Class {
	#name : 'SeaOfNodesCode',
	#superclass : 'Object',
	#instVars : [
		'dataResult',
		'startingRegion',
		'endingRegions',
		'allRegions'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SeaOfNodesCode >> allRegions [
	allRegions ifNil: [ self findRegions ].
	^ allRegions
]

{ #category : 'accessing' }
SeaOfNodesCode >> dataResult [

	^ dataResult
]

{ #category : 'accessing' }
SeaOfNodesCode >> dataResult: anObject [

	dataResult := anObject
]

{ #category : 'accessing' }
SeaOfNodesCode >> endingRegions [

	^ endingRegions
]

{ #category : 'accessing' }
SeaOfNodesCode >> endingRegions: anObject [

	endingRegions := anObject
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> findDataDependencies [
	| visitedSet |
	visitedSet := Set new.
	
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> findRegions [
	| seenRegionSet |
	allRegions := OrderedCollection new.
	seenRegionSet := Set new.
	startingRegion withAllSuccessorsDo: [ :each |
		(seenRegionSet includes: each) ifFalse: [ 
			seenRegionSet add: each.
			allRegions add: each
		]
	].
	^ allRegions
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> scheduleAndEvaluate [
	self scheduleInstructions.
	self halt
]

{ #category : 'as yet unclassified' }
SeaOfNodesCode >> scheduleInstructions [
	self findRegions.
	
]

{ #category : 'accessing' }
SeaOfNodesCode >> startingRegion [

	^ startingRegion
]

{ #category : 'accessing' }
SeaOfNodesCode >> startingRegion: anObject [

	startingRegion := anObject
]
