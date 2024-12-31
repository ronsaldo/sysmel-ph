Class {
	#name : 'SysmelParseTreeLiteralCharacterNode',
	#superclass : 'SysmelParseTreeLiteralNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLiteralCharacterNode >> accept: visitor [
	^ visitor visitLiteralCharacterNode: self
]

{ #category : 'testing' }
SysmelParseTreeLiteralCharacterNode >> isLiteralCharacterNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeLiteralCharacterNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelParseTreeLiteralCharacterNode >> value: anObject [

	value := anObject
]
