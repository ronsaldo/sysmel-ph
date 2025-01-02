Class {
	#name : 'SysmelPrimitiveIntegerTypeValue',
	#superclass : 'SysmelPrimitiveTypeValue',
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> * operand [
	<pure>
	^ primitiveType fromInteger: self asInteger * operand asInteger
]

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> + operand [
	<pure>
	^ primitiveType fromInteger: self asInteger + operand asInteger
]

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> - operand [
	<pure>
	^ primitiveType fromInteger: self asInteger - operand asInteger
]

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> / operand [
	<pure>
	^ primitiveType fromInteger: self asInteger // operand asInteger
]

{ #category : 'converting' }
SysmelPrimitiveIntegerTypeValue >> asInteger [
	^ value asInteger
]
