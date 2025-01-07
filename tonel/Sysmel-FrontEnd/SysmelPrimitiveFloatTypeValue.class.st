Class {
	#name : 'SysmelPrimitiveFloatTypeValue',
	#superclass : 'SysmelPrimitiveTypeValue',
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
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
