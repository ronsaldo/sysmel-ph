Class {
	#name : 'SysmelTypedLiteralNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedLiteralNode >> accept: visitor [
	^ visitor visitLiteralNode: self
]

{ #category : 'converting' }
SysmelTypedLiteralNode >> asReducedTypeExpression [
	^ self isTypeNode ifTrue: [value] ifFalse: [type]
]

{ #category : 'testing' }
SysmelTypedLiteralNode >> isLiteralNode [
	^ true
]

{ #category : 'testing' }
SysmelTypedLiteralNode >> isTypeNode [
	^ value isValidSysmelType
]

{ #category : 'printing' }
SysmelTypedLiteralNode >> printOn: aStream [
	aStream nextPutAll: 'literal('; print: value; nextPut: $)
]

{ #category : 'accessing' }
SysmelTypedLiteralNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelTypedLiteralNode >> value: anObject [

	value := anObject
]
