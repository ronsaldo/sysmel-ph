Class {
	#name : 'SymbolValueBinding',
	#superclass : 'SymbolBinding',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SymbolValueBinding >> evaluateASGIn: evalSourcePosition [
	^ SysmelTypedLiteralNode new
		sourcePosition: evalSourcePosition;
		value: value;
		type: value asSysmelType;
		yourself
]

{ #category : 'accessing' }
SymbolValueBinding >> value [

	^ value
]

{ #category : 'accessing' }
SymbolValueBinding >> value: anObject [

	value := anObject
]
