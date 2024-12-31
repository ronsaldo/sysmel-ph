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
SysmelParseTreeNode >> isLiteralCharacterNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralFloatNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralIntegerNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralStringNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralSymbolNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isParseErrorNode [
	^ false
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
