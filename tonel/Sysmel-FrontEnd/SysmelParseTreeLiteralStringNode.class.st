Class {
	#name : 'SysmelParseTreeLiteralStringNode',
	#superclass : 'SysmelParseTreeLiteralNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLiteralStringNode >> accept: visitor [
	^ visitor visitLiteralStringNode: self
]

{ #category : 'testing' }
SysmelParseTreeLiteralStringNode >> isLiteralStringNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeLiteralStringNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelParseTreeLiteralStringNode >> value: anObject [

	value := anObject
]
