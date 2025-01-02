Extension { #name : 'Integer' }

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i16 [
	<pure>
	^ SysmelType Int16 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i32 [
	<pure>
	^ SysmelType Int32 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i64 [
	<pure>
	^ SysmelType Int64 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i8 [
	<pure>
	^ SysmelType Int8 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u16 [
	<pure>
	^ SysmelType UInt16 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u32 [
	<pure>
	^ SysmelType UInt32 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u64 [
	<pure>
	^ SysmelType UInt64 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u8 [
	<pure>
	^ SysmelType UInt8 fromInteger: self
]
