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
