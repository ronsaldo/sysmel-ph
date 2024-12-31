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

{ #category : 'converting' }
SysmelParseTreeBinaryExpressionSequenceNode >> asMessageSendCascadeReceiverAndFirstMessage [
	| cascaded receiver selector argument |
	elements size ~= 3 ifTrue: [ ^ super asMessageSendCascadeReceiverAndFirstMessage ].
	receiver := elements first.
	selector := elements second.
	argument := elements third.
	cascaded := SysmelParseTreeMessageCascadeMessageNode new
		sourcePosition: sourcePosition;
		selector: selector;
		arguments: {argument};
		yourself.
	^ { receiver . cascaded }
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
