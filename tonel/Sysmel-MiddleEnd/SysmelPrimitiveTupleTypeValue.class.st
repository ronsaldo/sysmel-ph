Class {
	#name : 'SysmelPrimitiveTupleTypeValue',
	#superclass : 'SysmelPrimitiveTypeValue',
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'testing' }
SysmelPrimitiveTupleTypeValue >> isTuplePrimitiveTypeValue [
	^ true
]

{ #category : 'printing' }
SysmelPrimitiveTupleTypeValue >> printOn: aStream [
	primitiveType printOn: aStream.
	aStream nextPut: $(.
	value printOn: aStream.
	aStream nextPut: $).
]
