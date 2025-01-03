Class {
	#name : 'SoNLambdaNode',
	#superclass : 'SoNTypedFunctionalNode',
	#instVars : [
		'seaOfNodesCode'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'testing' }
SoNLambdaNode >> isLambdaNode [
	^ true
]

{ #category : 'accessing' }
SoNLambdaNode >> seaOfNodesCode [

	^ seaOfNodesCode
]

{ #category : 'accessing' }
SoNLambdaNode >> seaOfNodesCode: anObject [

	seaOfNodesCode := anObject
]
