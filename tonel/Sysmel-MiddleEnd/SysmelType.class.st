Class {
	#name : 'SysmelType',
	#superclass : 'SysmelProgramEntity',
	#instVars : [
		'sourcePosition',
		'optionalName'
	],
	#classVars : [
		'Char16',
		'Char32',
		'Char8',
		'Int16',
		'Int32',
		'Int64',
		'Int8',
		'UInt16',
		'UInt32',
		'UInt64',
		'UInt8'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'primitive types' }
SysmelType class >> Char16 [
	^ Char16 ifNil: [Char16 := SysmelPrimitiveCharacterType new
			optionalName: #Char16;
			size: 2;
			alignment: 2;
			literalSuffix: #c16;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> Char32 [
	^ Char32 ifNil: [Char32 := SysmelPrimitiveCharacterType new
			optionalName: #Char32;
			size: 4; 
			alignment: 4;
			literalSuffix: #c32;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> Char8 [
	^ Char8 ifNil: [Char8 := SysmelPrimitiveCharacterType new
			optionalName: #Char8;
			size: 1;
			alignment: 1;
			literalSuffix: #c8;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> Int16 [
	^ Int16 ifNil: [Int16 := SysmelPrimitiveSignedIntegerType new
			optionalName: #Int16;
			size: 2;
			alignment: 2;
			literalSuffix: #i16;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> Int32 [
	^ Int32 ifNil: [Int32 := SysmelPrimitiveSignedIntegerType new
			optionalName: #Int32;
			size: 4;
			alignment: 4;
			literalSuffix: #i32;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> Int64 [
	^ Int64 ifNil: [Int64 := SysmelPrimitiveSignedIntegerType new
			optionalName: #Int64;
			size: 8;
			alignment: 8;
			literalSuffix: #i64;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> Int8 [
	^ Int8 ifNil: [Int8 := SysmelPrimitiveSignedIntegerType new
			optionalName: #Int8;
			size: 1;
			alignment: 1;
			literalSuffix: #i8;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> UInt16 [
	^ UInt16 ifNil: [UInt16 := SysmelPrimitiveUnsignedIntegerType new
			optionalName: #UInt16;
			size: 2;
			alignment: 2;
			literalSuffix: #u16;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> UInt32 [
	^ UInt32 ifNil: [UInt32 := SysmelPrimitiveUnsignedIntegerType new
			optionalName: #UInt32;
			size: 4;
			alignment: 4;
			literalSuffix: #u32;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> UInt64 [
	^ UInt64 ifNil: [UInt64 := SysmelPrimitiveUnsignedIntegerType new
			optionalName: #UInt64;
			size: 8;
			alignment: 8;
			literalSuffix: #u64;
			yourself]
]

{ #category : 'primitive types' }
SysmelType class >> UInt8 [
	^ UInt8 ifNil: [UInt8 := SysmelPrimitiveUnsignedIntegerType new
			optionalName: #UInt8;
			size: 1;
			alignment: 1;
			literalSuffix: #u8;
			yourself]
]

{ #category : 'testing' }
SysmelType class >> isVoidType [
	^ false
]

{ #category : 'converting' }
SysmelType >> asDecayedSysmelType [
	^ self
]

{ #category : 'testing' }
SysmelType >> isGradualType [
	^ false
]

{ #category : 'testing' }
SysmelType >> isPointerLikeType [
	^ false
]

{ #category : 'testing' }
SysmelType >> isReferenceLikeType [
	^ false
]

{ #category : 'testing' }
SysmelType >> isValidSysmelType [
	^ true
]

{ #category : 'testing' }
SysmelType >> isVoid [
	^ false
]

{ #category : 'testing' }
SysmelType >> isVoidType [
	^ false
]

{ #category : 'lookup' }
SysmelType >> lookupSelector: aSelector [
	^ nil
]

{ #category : 'accessing' }
SysmelType >> optionalName [

	^ optionalName
]

{ #category : 'accessing' }
SysmelType >> optionalName: anObject [

	optionalName := anObject
]

{ #category : 'printing' }
SysmelType >> printOn: aStream [
	optionalName ifNotNil: [ ^aStream nextPutAll: optionalName ].
	^ super printOn: aStream
]

{ #category : 'accessing' }
SysmelType >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelType >> sourcePosition: anObject [

	sourcePosition := anObject
]
