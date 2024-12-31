"
I am a sysmel parse tree node.
"
Class {
	#name : 'SysmelParseTreeNode',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeNode >> accept: visitor [
	^ self subclassResponsibility
]

{ #category : 'testing' }
SysmelParseTreeNode >> isSequenceNode [
	^ false
]

{ #category : 'accessing' }
SysmelParseTreeNode >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelParseTreeNode >> sourcePosition: anObject [

	sourcePosition := anObject
]
