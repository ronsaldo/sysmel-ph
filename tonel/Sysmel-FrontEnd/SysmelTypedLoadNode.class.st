Class {
	#name : 'SysmelTypedLoadNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'pointer'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedLoadNode >> accept: visitor [
	^ visitor visitLoadNode: self
]

{ #category : 'accessing' }
SysmelTypedLoadNode >> pointer [
	^ pointer
]

{ #category : 'accessing' }
SysmelTypedLoadNode >> pointer: anObject [

	pointer := anObject
]
