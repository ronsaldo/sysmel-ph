Extension { #name : 'Integer' }

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i16 [
	<pure>
	<resultType: #Int16>
	^ SysmelType Int16 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i32 [
	<pure>
	<resultType: #Int32>
	^ SysmelType Int32 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i64 [
	<pure>
	<resultType: #Int64>
	^ SysmelType Int64 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> i8 [
	<pure>
	<resultType: #Int8>
	^ SysmelType Int8 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u16 [
	<pure>
	<resultType: #UInt16>
	^ SysmelType UInt16 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u32 [
	<pure>
	<resultType: #UInt32>
	^ SysmelType UInt32 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u64 [
	<pure>
	<resultType: #UInt64>
	^ SysmelType UInt64 fromInteger: self
]

{ #category : '*Sysmel-MiddleEnd' }
Integer >> u8 [
	<pure>
	<resultType: #UInt8>
	^ SysmelType UInt8 fromInteger: self
]
