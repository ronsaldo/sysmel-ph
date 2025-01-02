Class {
	#name : 'SoNGraphNode',
	#superclass : 'SysmelProgramEntity',
	#instVars : [
		'sourcePosition'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'converting' }
SoNGraphNode >> asConstantValueForPureEvaluation [
	^ self error: 'Not a constant value.'
]

{ #category : 'converting' }
SoNGraphNode >> asReducedTypeExpression [
	^ self
]

{ #category : 'testing' }
SoNGraphNode >> isAllocaGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isApplicationGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isAssociationGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isConstantDataNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isControlFlowNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isDictionaryGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isLambdaNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isLiteralValueGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isLoadValueGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isPhiCopyGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isPhiGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isPiNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isSendMessageGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isSequencingGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isSigmaNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isStoreValueGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isTupleGraphNode [
	^ false
]

{ #category : 'testing' }
SoNGraphNode >> isTypeNode [
	^ false
]

{ #category : 'accessing' }
SoNGraphNode >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SoNGraphNode >> sourcePosition: anObject [

	sourcePosition := anObject
]

{ #category : 'accessing' }
SoNGraphNode >> type [
	^ self subclassResponsibility
]
