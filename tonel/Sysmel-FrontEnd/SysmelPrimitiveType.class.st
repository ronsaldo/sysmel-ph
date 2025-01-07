Class {
	#name : 'SysmelPrimitiveType',
	#superclass : 'SysmelType',
	#instVars : [
		'size',
		'alignment',
		'literalSuffix'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelPrimitiveType >> alignment [

	^ alignment
]

{ #category : 'accessing' }
SysmelPrimitiveType >> alignment: anObject [

	alignment := anObject
]

{ #category : 'instance creation' }
SysmelPrimitiveType >> fromInteger: anInteger [
	| normalizedInteger |
	normalizedInteger := self normalizeInteger: anInteger. 
	^ SysmelPrimitiveIntegerTypeValue new
		sourcePosition: self sourcePosition;
		value: normalizedInteger;
		primitiveType: self;
		yourself
]

{ #category : 'accessing' }
SysmelPrimitiveType >> literalSuffix [

	^ literalSuffix
]

{ #category : 'accessing' }
SysmelPrimitiveType >> literalSuffix: anObject [

	literalSuffix := anObject
]

{ #category : 'lookup' }
SysmelPrimitiveType >> lookupSelector: aSelector [
	^ SysmelPrimitiveIntegerTypeValue lookupSelector: aSelector
]

{ #category : 'as yet unclassified' }
SysmelPrimitiveType >> normalizeInteger: integer [
	^ integer bitAnd: (1<<(size * 8)) - 1
]

{ #category : 'instance creation' }
SysmelPrimitiveType >> one [
	^ self fromInteger: 1
]

{ #category : 'accessing' }
SysmelPrimitiveType >> size [

	^ size
]

{ #category : 'accessing' }
SysmelPrimitiveType >> size: anObject [

	size := anObject
]

{ #category : 'instance creation' }
SysmelPrimitiveType >> zero [
	^ self fromInteger: 0
]
