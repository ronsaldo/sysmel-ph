Class {
	#name : 'SysmelGlobalCodeMotionAlgorithm',
	#superclass : 'Object',
	#instVars : [
		'regions',
		'instructions'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SysmelGlobalCodeMotionAlgorithm >> findInstructionOf: seaOfNodeCode [
]

{ #category : 'as yet unclassified' }
SysmelGlobalCodeMotionAlgorithm >> findRegionsOf: aSeaOfNodeCode [
	| visited ordered topoSortBlock |
	visited := IdentitySet new.
	ordered := OrderedCollection new.
	topoSortBlock := [ :region |
		(visited includes: region) ifFalse: [
			visited add: region.
			
			region immediateDominator ifNotNil: [ :idom |
				 topoSortBlock value: idom
			].
		
			region previousRegions do: topoSortBlock.
			
			ordered add: region
		]
	].
	
	aSeaOfNodeCode endingRegions do: topoSortBlock.
	^ ordered
]

{ #category : 'running' }
SysmelGlobalCodeMotionAlgorithm >> runOn: aSeaOfNodesCode [
	regions := self findRegionsOf: aSeaOfNodesCode.
	instructions := self findInstructionOf: aSeaOfNodesCode.
	self halt
]
