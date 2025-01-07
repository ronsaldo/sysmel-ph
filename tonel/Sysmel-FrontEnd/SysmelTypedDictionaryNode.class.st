Class {
	#name : 'SysmelTypedDictionaryNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedDictionaryNode >> accept: visitor [
	^ visitor visitDictionaryNode: self
]

{ #category : 'accessing' }
SysmelTypedDictionaryNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelTypedDictionaryNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SysmelTypedDictionaryNode >> isDictionaryNode [
	^ true
]
