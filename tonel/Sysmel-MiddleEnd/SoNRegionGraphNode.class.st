Class {
	#name : 'SoNRegionGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'mergePhi',
		'phiCopy',
		'instructions',
		'terminatorInstruction',
		'earlyInstructionSchedule',
		'nextRegions',
		'immediateDominator',
		'previousRegions',
		'dominatorTreeDepth',
		'lateInstructionSchedule'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'adding' }
SoNRegionGraphNode >> addEarlyScheduledInstruction: anInstruction [
	earlyInstructionSchedule add: anInstruction.
]

{ #category : 'adding' }
SoNRegionGraphNode >> addInstruction: anInstruction [
	anInstruction isBasicBlockTerminator ifTrue: [
		anInstruction ownerRegion: self.
		^ terminatorInstruction := anInstruction.
	].

	anInstruction isConstantDataNode ifFalse: [
		anInstruction ownerRegion: self.
		instructions add: anInstruction.
	].
	^ anInstruction
]

{ #category : 'adding' }
SoNRegionGraphNode >> addLateScheduledInstruction: anInstruction [
	lateInstructionSchedule add: anInstruction.
]

{ #category : 'adding' }
SoNRegionGraphNode >> addMergePhi: node [
	mergePhi add: node.
	node ownerRegion: self.
]

{ #category : 'adding' }
SoNRegionGraphNode >> addPhiCopy: node [
	phiCopy add: node.
	node ownerRegion: self.
]

{ #category : 'adding' }
SoNRegionGraphNode >> addPredecessor: aRegion [
	previousRegions add: aRegion
]

{ #category : 'adding' }
SoNRegionGraphNode >> addSuccessor: aRegion [
	nextRegions add: aRegion
]

{ #category : 'enumerating' }
SoNRegionGraphNode >> allInstructionsDo: aBlock [
	mergePhi do: aBlock.
	instructions do: aBlock.
	phiCopy do: aBlock.
	terminatorInstruction ifNotNil: [ aBlock value: terminatorInstruction ].
]

{ #category : 'enumerating' }
SoNRegionGraphNode >> allInstructionsReverseDo: aBlock [
	terminatorInstruction ifNotNil: [ aBlock value: terminatorInstruction ].
	phiCopy do: aBlock.
	instructions do: aBlock.
	mergePhi do: aBlock.

]

{ #category : 'accessing' }
SoNRegionGraphNode >> dominatorTreeDepth [
	^ dominatorTreeDepth ifNil: [
		dominatorTreeDepth := 0.
		immediateDominator ifNotNil: [
			dominatorTreeDepth := dominatorTreeDepth + immediateDominator dominatorTreeDepth + 1
		]
	]
]

{ #category : 'accessing' }
SoNRegionGraphNode >> earlyInstructionSchedule [
	^ earlyInstructionSchedule
]

{ #category : 'accessing' }
SoNRegionGraphNode >> immediateDominator [

	^ immediateDominator
]

{ #category : 'accessing' }
SoNRegionGraphNode >> immediateDominator: anObject [

	immediateDominator := anObject
]

{ #category : 'initialization' }
SoNRegionGraphNode >> initialize [
	super initialize.
	mergePhi := OrderedCollection new.
	nextRegions := OrderedCollection new.
	previousRegions := OrderedCollection new.
	instructions := OrderedCollection new.
	phiCopy := OrderedCollection new.
	earlyInstructionSchedule := OrderedCollection new.
	lateInstructionSchedule := OrderedCollection new.
]

{ #category : 'accessing' }
SoNRegionGraphNode >> instructions [

	^ instructions
]

{ #category : 'accessing' }
SoNRegionGraphNode >> instructions: anObject [

	instructions := anObject
]

{ #category : 'testing' }
SoNRegionGraphNode >> isEmpty [
	^ instructions isEmpty and: [ phiCopy isEmpty and: [ mergePhi isEmpty ] ]
]

{ #category : 'accessing' }
SoNRegionGraphNode >> lateInstructionSchedule [
	^ lateInstructionSchedule
]

{ #category : 'accessing' }
SoNRegionGraphNode >> nextRegions [

	^ nextRegions
]

{ #category : 'accessing' }
SoNRegionGraphNode >> nextRegions: anObject [

	nextRegions := anObject
]

{ #category : 'accessing' }
SoNRegionGraphNode >> previousRegions [

	^ previousRegions
]

{ #category : 'accessing' }
SoNRegionGraphNode >> previousRegions: anObject [

	previousRegions := anObject
]

{ #category : 'accessing' }
SoNRegionGraphNode >> terminatorInstruction [

	^ terminatorInstruction
]

{ #category : 'accessing' }
SoNRegionGraphNode >> terminatorInstruction: anObject [
	terminatorInstruction := anObject.
	terminatorInstruction ownerRegion: self
]

{ #category : 'accessing' }
SoNRegionGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]

{ #category : 'enumerating' }
SoNRegionGraphNode >> withAllSuccessorsDo: aBlock [
	aBlock value: self.
	nextRegions do: [:each | each withAllSuccessorsDo: aBlock ]
]
