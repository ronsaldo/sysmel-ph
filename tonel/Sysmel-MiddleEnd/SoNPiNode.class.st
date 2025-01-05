Class {
	#name : 'SoNPiNode',
	#superclass : 'SoNTypedFunctionalNode',
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'testing' }
SoNPiNode >> isPiNode [
	^ true
]

{ #category : 'testing' }
SoNPiNode >> isReferenceLikeType [
	^ false
]
