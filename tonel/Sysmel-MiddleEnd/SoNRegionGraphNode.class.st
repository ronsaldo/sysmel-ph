Class {
	#name : 'SoNRegionGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'instructions'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'adding' }
SoNRegionGraphNode >> addInstruction: anInstruction [
	instructions add: anInstruction.
	^ anInstruction
]

{ #category : 'initialization' }
SoNRegionGraphNode >> initialize [
	super initialize.
	instructions := OrderedCollection new
]

{ #category : 'accessing' }
SoNRegionGraphNode >> instructions [

	^ instructions
]

{ #category : 'accessing' }
SoNRegionGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]
