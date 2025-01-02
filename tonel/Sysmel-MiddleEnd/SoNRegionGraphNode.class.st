Class {
	#name : 'SoNRegionGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'mergePhi',
		'phiCopy',
		'instructions',
		'nextRegions',
		'immediateDominator',
		'previousRegions'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'adding' }
SoNRegionGraphNode >> addInstruction: anInstruction [
	anInstruction isConstantDataNode ifFalse: [
		instructions add: anInstruction.
	].
	^ anInstruction
]

{ #category : 'adding' }
SoNRegionGraphNode >> addMergePhi: node [
	mergePhi add: node
]

{ #category : 'adding' }
SoNRegionGraphNode >> addPhiCopy: node [
	phiCopy add: node
]

{ #category : 'adding' }
SoNRegionGraphNode >> addPredecessor: aRegion [
	previousRegions add: aRegion
]

{ #category : 'adding' }
SoNRegionGraphNode >> addSuccessor: aRegion [
	nextRegions add: aRegion
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
SoNRegionGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]

{ #category : 'enumerating' }
SoNRegionGraphNode >> withAllSuccessorsDo: aBlock [
	aBlock value: self.
	nextRegions do: [:each | each withAllSuccessorsDo: aBlock ]
]
