Class {
	#name : 'SysmelPrimitiveTypeValue',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition',
		'value',
		'primitiveType'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'converting' }
SysmelPrimitiveTypeValue >> asSysmelType [
	^ primitiveType
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> primitiveType [

	^ primitiveType
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> primitiveType: anObject [

	primitiveType := anObject
]

{ #category : 'printing' }
SysmelPrimitiveTypeValue >> printOn: aStream [
	value printOn: aStream.
	aStream nextPutAll: primitiveType literalSuffix
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> sourcePosition: anObject [

	sourcePosition := anObject
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> value [

	^ value
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> value: anObject [

	value := anObject
]
