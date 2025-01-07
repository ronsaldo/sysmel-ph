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
SysmelTypedGraphNode >> isLiteralNode [
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
