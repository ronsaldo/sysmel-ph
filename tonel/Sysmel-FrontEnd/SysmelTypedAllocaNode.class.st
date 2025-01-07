Class {
	#name : 'SysmelTypedAllocaNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'valueType',
		'exportableName'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedAllocaNode >> accept: visitor [
	^ visitor visitAllocaNode: self
]

{ #category : 'accessing' }
SysmelTypedAllocaNode >> exportableName [

	^ exportableName
]

{ #category : 'accessing' }
SysmelTypedAllocaNode >> exportableName: anObject [

	exportableName := anObject
]

{ #category : 'testing' }
SysmelTypedAllocaNode >> isAllocaGraphNode [
	^ true
]

{ #category : 'accessing' }
SysmelTypedAllocaNode >> valueType [

	^ valueType
]

{ #category : 'accessing' }
SysmelTypedAllocaNode >> valueType: anObject [

	valueType := anObject
]
