Class {
	#name : 'SoNLiteralValueGraphNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'value',
		'type',
		'exportableName'
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

{ #category : 'as yet unclassified' }
SoNLiteralValueGraphNode >> evaluateWithContext: evaluationContext [
	^ evaluationContext setValue: value andAdvancePC: 1
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> exportableName [

	^ exportableName
]

{ #category : 'accessing' }
SoNLiteralValueGraphNode >> exportableName: anObject [

	exportableName := anObject
]

{ #category : 'as yet unclassified' }
SoNLiteralValueGraphNode >> findAllExportableObjects [
	^ exportableName
		ifNotNil: [ { self } ]
		ifNil: [ #() ]
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
