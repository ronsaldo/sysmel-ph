Class {
	#name : 'SysmelPrimitiveTypeValue',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition',
		'value',
		'primitiveType'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'comparing' }
SysmelPrimitiveTypeValue >> = other [
	self class == other class ifFalse: [ ^ false ].
	^ value = other value. 
]

{ #category : 'converting' }
SysmelPrimitiveTypeValue >> asSysmelType [
	^ primitiveType
]

{ #category : 'testing' }
SysmelPrimitiveTypeValue >> isPrimitiveTypeValue [
	^ true
]

{ #category : 'testing' }
SysmelPrimitiveTypeValue >> isSysmelNamespace [
	^ false
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> primitiveType [

	^ primitiveType
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> primitiveType: anObject [

	primitiveType := anObject
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
SysmelPrimitiveTypeValue >> type [
	^ primitiveType
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> value [

	^ value
]

{ #category : 'accessing' }
SysmelPrimitiveTypeValue >> value: anObject [

	value := anObject
]
