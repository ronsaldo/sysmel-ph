Class {
	#name : 'SysmelParseTreeMessageCascadeMessageNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'selector',
		'arguments'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeMessageCascadeMessageNode >> accept: visitor [
	^ visitor visitMessageCascadeMessageNode: self
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeMessageNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeMessageNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'visiting' }
SysmelParseTreeMessageCascadeMessageNode >> isMessageCascadeMessageNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeMessageNode >> selector [

	^ selector
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeMessageNode >> selector: anObject [

	selector := anObject
]
