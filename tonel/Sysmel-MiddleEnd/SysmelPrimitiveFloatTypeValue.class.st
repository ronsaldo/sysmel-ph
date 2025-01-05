Class {
	#name : 'SysmelPrimitiveFloatTypeValue',
	#superclass : 'SysmelPrimitiveTypeValue',
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'converting' }
SysmelPrimitiveFloatTypeValue >> asFloat [
	^ value asFloat
]

{ #category : 'printing' }
SysmelPrimitiveFloatTypeValue >> printOn: aStream [
	value printOn: aStream.
	aStream nextPutAll: primitiveType literalSuffix
]
