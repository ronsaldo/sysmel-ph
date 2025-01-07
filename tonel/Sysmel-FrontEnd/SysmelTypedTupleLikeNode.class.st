Class {
	#name : 'SysmelTypedTupleLikeNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'accessing' }
SysmelTypedTupleLikeNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelTypedTupleLikeNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SysmelTypedTupleLikeNode >> hasDictionaryAsInput: hasDictionaryConstruction [
	"By default do nothing"
]
