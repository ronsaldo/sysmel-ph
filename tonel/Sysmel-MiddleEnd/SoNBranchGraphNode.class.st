Class {
	#name : 'SoNBranchGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'destination'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNBranchGraphNode >> destination [

	^ destination
]

{ #category : 'accessing' }
SoNBranchGraphNode >> destination: anObject [

	destination := anObject
]

{ #category : 'accessing' }
SoNBranchGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]
