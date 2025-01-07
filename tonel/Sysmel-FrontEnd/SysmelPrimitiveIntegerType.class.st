Class {
	#name : 'SysmelPrimitiveIntegerType',
	#superclass : 'SysmelPrimitiveType',
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelPrimitiveIntegerType >> defaultValue [
	^ self fromInteger: 0
]
