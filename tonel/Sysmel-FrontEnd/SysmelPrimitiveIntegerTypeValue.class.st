Class {
	#name : 'SysmelPrimitiveIntegerTypeValue',
	#superclass : 'SysmelPrimitiveTypeValue',
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
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

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> < operand [
	<pure>
	<resultType: #Boolean>
	^ self value < operand value 
]

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> <= operand [
	<pure>
	<resultType: #Boolean>
	^ self value <= operand value 
]

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> > operand [
	<pure>
	<resultType: #Boolean>
	^ self value > operand value 
]

{ #category : 'arithmetic' }
SysmelPrimitiveIntegerTypeValue >> >= operand [
	<pure>
	<resultType: #Boolean>
	^ self value >= operand value 
]

{ #category : 'converting' }
SysmelPrimitiveIntegerTypeValue >> asInteger [
	^ value asInteger
]

{ #category : 'accessing' }
SysmelPrimitiveIntegerTypeValue >> increment [
	^ self class new
		sourcePosition: sourcePosition;
		value: value + 1;
		primitiveType: primitiveType;
		yourself
]

{ #category : 'printing' }
SysmelPrimitiveIntegerTypeValue >> printOn: aStream [
	value printOn: aStream.
	aStream nextPutAll: primitiveType literalSuffix
]
