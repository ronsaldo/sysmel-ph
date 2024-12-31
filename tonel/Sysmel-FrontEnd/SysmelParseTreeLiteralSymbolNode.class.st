Class {
	#name : 'SysmelParseTreeLiteralSymbolNode',
	#superclass : 'SysmelParseTreeLiteralNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLiteralSymbolNode >> accept: visitor [
	^ visitor visitLiteralSymbolNode: self
]

{ #category : 'testing' }
SysmelParseTreeLiteralSymbolNode >> isLiteralSymbolNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeLiteralSymbolNode >> value [
	^ value
]

{ #category : 'accessing' }
SysmelParseTreeLiteralSymbolNode >> value1 [

	^ value
]

{ #category : 'accessing' }
SysmelParseTreeLiteralSymbolNode >> value: anObject [

	value := anObject
]
