Class {
	#name : 'SysmelParseTreeLiteralIntegerNode',
	#superclass : 'SysmelParseTreeLiteralNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLiteralIntegerNode >> accept: visitor [
	^ visitor visitLiteralIntegerNode: self
]

{ #category : 'testing' }
SysmelParseTreeLiteralIntegerNode >> isLiteralIntegerNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeLiteralIntegerNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelParseTreeLiteralIntegerNode >> value: anObject [

	value := anObject
]
