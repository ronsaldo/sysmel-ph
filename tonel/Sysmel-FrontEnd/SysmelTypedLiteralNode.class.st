Class {
	#name : 'SysmelTypedLiteralNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedLiteralNode >> accept: visitor [
	^ visitor visitLiteralNode: self
]

{ #category : 'testing' }
SysmelTypedLiteralNode >> isLiteralNode [
	^ true
]

{ #category : 'accessing' }
SysmelTypedLiteralNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelTypedLiteralNode >> value: anObject [

	value := anObject
]
