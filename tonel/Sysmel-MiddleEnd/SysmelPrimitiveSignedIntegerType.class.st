Class {
	#name : 'SysmelPrimitiveSignedIntegerType',
	#superclass : 'SysmelPrimitiveIntegerType',
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'as yet unclassified' }
SysmelPrimitiveSignedIntegerType >> normalizeInteger: integer [
	| unsignedBits signBit |
	unsignedBits := (1<<(size * 8 - 1 )) - 1.
	signBit := 1<< (size * 8 - 1).
	^ (integer bitAnd: unsignedBits) - (integer bitAnd: signBit)
]
