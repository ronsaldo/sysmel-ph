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

{ #category : 'as yet unclassified' }
SoNBranchGraphNode >> evaluateWithContext: evaluationContext [
	evaluationContext pc: destination firstIndex.
]

{ #category : 'testing' }
SoNBranchGraphNode >> isBasicBlockTerminator [
	^ true
]

{ #category : 'testing' }
SoNBranchGraphNode >> isControlFlowNode [
	^ true
]

{ #category : 'testing' }
SoNBranchGraphNode >> isPinnedInstruction [
	^ true
]

{ #category : 'accessing' }
SoNBranchGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]
