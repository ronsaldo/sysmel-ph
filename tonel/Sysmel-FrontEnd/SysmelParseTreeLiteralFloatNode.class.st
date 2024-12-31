Class {
	#name : 'SysmelParseTreeLiteralFloatNode',
	#superclass : 'SysmelParseTreeLiteralNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLiteralFloatNode >> accept: visitor [
	^ visitor visitLiteralFloatNode: self
]

{ #category : 'testing' }
SysmelParseTreeLiteralFloatNode >> isLiteralFloatNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeLiteralFloatNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelParseTreeLiteralFloatNode >> value: anObject [

	value := anObject
]
