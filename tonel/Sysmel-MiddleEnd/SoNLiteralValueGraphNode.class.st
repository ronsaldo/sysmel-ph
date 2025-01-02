Class {
	#name : 'SoNLiteralValueGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'value',
		'type'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SoNLiteralValueGraphNode class >> voidValue [
	^ self new value: SysmelVoidType uniqueInstance; type: SysmelVoidType
]

{ #category : 'converting' }
SoNLiteralValueGraphNode >> asConstantValueForPureEvaluation [
	^ value
]

{ #category : 'converting' }
SoNLiteralValueGraphNode >> asReducedTypeExpression [
	^ self isTypeNode ifTrue: [value] ifFalse: [type]
]

{ #category : 'testing' }
SoNLiteralValueGraphNode >> isConstantDataNode [
	^ true
]

{ #category : 'testing' }
SoNLiteralValueGraphNode >> isLiteralValueGraphNode [
	^ true
]

{ #category : 'testing' }
SoNLiteralValueGraphNode >> isTypeNode [
	^ value isValidSysmelType
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> value [

	^ value
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> value: anObject [

	value := anObject
]
