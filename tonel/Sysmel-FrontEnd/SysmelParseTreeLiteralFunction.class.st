Class {
	#name : 'SysmelParseTreeLiteralFunction',
	#superclass : 'SysmelParseTreeLiteralNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLiteralFunction >> accept: visitor [
	^ visitor visitLiteralFunctionNode: self
]

{ #category : 'testing' }
SysmelParseTreeLiteralFunction >> isLiteralFunctionNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeLiteralFunction >> value [

	^ value
]

{ #category : 'accessing' }
SysmelParseTreeLiteralFunction >> value: anObject [

	value := anObject
]
