Class {
	#name : 'SoNConditionalBranchGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'condition',
		'trueDestination',
		'falseDestination',
		'mergeDestination'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> condition [

	^ condition
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> condition: anObject [
	condition := anObject.
	condition addUser: self
]

{ #category : 'as yet unclassified' }
SoNConditionalBranchGraphNode >> dataDependenciesDo: aBlock [
	aBlock value: condition.
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> falseDestination [

	^ falseDestination
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> falseDestination: anObject [

	falseDestination := anObject
]

{ #category : 'testing' }
SoNConditionalBranchGraphNode >> isBasicBlockTerminator [
	^ true
]

{ #category : 'testing' }
SoNConditionalBranchGraphNode >> isControlFlowNode [
	^ true
]

{ #category : 'testing' }
SoNConditionalBranchGraphNode >> isPinnedInstruction [
	^ true
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> mergeDestination [

	^ mergeDestination
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> mergeDestination: anObject [

	mergeDestination := anObject
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> trueDestination [

	^ trueDestination
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> trueDestination: anObject [

	trueDestination := anObject
]

{ #category : 'accessing' }
SoNConditionalBranchGraphNode >> type [
	^ SysmelVoidType uniqueInstance
]
