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
SysmelGlobalCodeMotionAlgorithm >> findInstructionOf: regions [
	| visited allInstructions instructionsDFS |
	visited := IdentitySet new.
	allInstructions := OrderedCollection new.
	instructionsDFS := [ :instruction |
		(visited includes: instruction) ifFalse: [
			visited add: instruction.
			instruction dataDependenciesDo: instructionsDFS.
			allInstructions add: instruction
		]
	].
	regions do: [ :region |
		(visited includes: region) ifFalse: [
			visited add: region.
			region allInstructionsDo: instructionsDFS
		]. 
	].
	^ allInstructions
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
	instructions := self findInstructionOf: regions.
	self scheduleEarly.
	self scheduleLater.
	
	^ SysmelScheduledRegionsAndInstructionsAlgorithm new
		regions: regions;
		instructions: instructions;
		yourself
]

{ #category : 'as yet unclassified' }
SysmelGlobalCodeMotionAlgorithm >> scheduleEarly [
	| visited |
	visited := IdentitySet new.
	instructions select: [:each | each isPinnedInstruction ] thenDo: [ :eachInstruction |
		(visited includes: eachInstruction) ifFalse: [
			visited add: eachInstruction.
			eachInstruction dataDependenciesDo: [ :eachDependency |
				self scheduleEarly: eachDependency visitedSet: visited
			].
			eachInstruction ownerRegion addEarlyScheduledInstruction: eachInstruction
		]
	]
]

{ #category : 'as yet unclassified' }
SysmelGlobalCodeMotionAlgorithm >> scheduleEarly: instruction visitedSet: visited [
	| root |
	(visited includes: instruction) ifTrue: [ ^ self ].
	visited add: instruction.
	
	root := regions first.
	instruction ownerRegion: root.

	instruction dataDependenciesDo: [ :eachDependency |
		self scheduleEarly: eachDependency visitedSet: visited.
		instruction ownerRegion dominatorTreeDepth < eachDependency ownerRegion dominatorTreeDepth ifTrue: [ 
			instruction ownerRegion: eachDependency ownerRegion
		]
	].
	instruction ownerRegion addEarlyScheduledInstruction: instruction.
	

]

{ #category : 'as yet unclassified' }
SysmelGlobalCodeMotionAlgorithm >> scheduleLater [
	self flag: 'TODO: implement myself'
]
