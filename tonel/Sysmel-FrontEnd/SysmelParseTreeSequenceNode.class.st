Class {
	#name : 'SysmelParseTreeSequenceNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeSequenceNode >> accept: visitor [
	^ visitor visitSequenceNode: self
]

{ #category : 'accessing' }
SysmelParseTreeSequenceNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelParseTreeSequenceNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SysmelParseTreeSequenceNode >> isSequenceNode [
	^ true
]
