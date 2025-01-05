Class {
	#name : 'SysmelPrimitiveIntegerType',
	#superclass : 'SysmelPrimitiveType',
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelPrimitiveIntegerType >> defaultValue [
	^ self fromInteger: 0
]
