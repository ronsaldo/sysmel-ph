Class {
	#name : 'SysmelParseTreeBinaryExpressionSequenceNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeBinaryExpressionSequenceNode >> accept: visitor [
	^ visitor visitBinaryExpressionSequenceNode: self
]

{ #category : 'accessing' }
SysmelParseTreeBinaryExpressionSequenceNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelParseTreeBinaryExpressionSequenceNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SysmelParseTreeBinaryExpressionSequenceNode >> isBinaryExpressionSequenceNode [
	^ true
]
