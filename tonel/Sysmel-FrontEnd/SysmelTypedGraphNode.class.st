Class {
	#name : 'SysmelTypedGraphNode',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition',
		'type'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedGraphNode >> accept: visitor [
	self subclassResponsibility
]

{ #category : 'testing' }
SysmelTypedGraphNode >> asConstantValueForPureEvaluation [
	^ self error: 'Not a constant value.'
]

{ #category : 'as yet unclassified' }
SysmelTypedGraphNode >> findAllExportableObjects [
	^ #()
]

{ #category : 'testing' }
SysmelTypedGraphNode >> isConstantDataNode [
	^ false
]

{ #category : 'testing' }
SysmelTypedGraphNode >> isDictionaryNode [
	^ false
]

{ #category : 'testing' }
SysmelTypedGraphNode >> isIfNode [
	^ false
]

{ #category : 'testing' }
SysmelTypedGraphNode >> isLiteralNode [
	^ false
]

{ #category : 'testing' }
SysmelTypedGraphNode >> isNamespaceLike [
	^ false
]

{ #category : 'testing' }
SysmelTypedGraphNode >> isSysmelGraphNode [
	^ true
]

{ #category : 'testing' }
SysmelTypedGraphNode >> isSysmelNamespace [
	^ false
]

{ #category : 'accessing' }
SysmelTypedGraphNode >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelTypedGraphNode >> sourcePosition: anObject [

	sourcePosition := anObject
]

{ #category : 'accessing' }
SysmelTypedGraphNode >> type [

	^ type
]

{ #category : 'accessing' }
SysmelTypedGraphNode >> type: anObject [

	type := anObject
]
