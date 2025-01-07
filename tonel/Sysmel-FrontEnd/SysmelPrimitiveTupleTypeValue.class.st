Class {
	#name : 'SysmelPrimitiveTupleTypeValue',
	#superclass : 'SysmelPrimitiveTypeValue',
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'testing' }
SysmelPrimitiveTupleTypeValue >> isTuplePrimitiveTypeValue [
	^ true
]

{ #category : 'printing' }
SysmelPrimitiveTupleTypeValue >> printOn: aStream [
	primitiveType printOn: aStream.
	aStream nextPut: $(.
	value printOn: aStream.
	aStream nextPut: $).
]

{ #category : 'as yet unclassified' }
SysmelPrimitiveTupleTypeValue >> sysmelPerform: selector withArguments: arguments [
	| fieldSelector isAssignment fieldIndex |
	fieldSelector := selector.
	isAssignment := selector endsWith: ':'.
	isAssignment ifTrue: [
		fieldSelector := selector allButLast asSymbol.
	].
	fieldIndex := primitiveType nameToIndex: fieldSelector.
	fieldIndex ifNil: [ ^ super sysmelPerform: selector withArguments: arguments ].
	
	^ isAssignment ifTrue: [
		value at: fieldIndex put: arguments first
	] ifFalse: [
		value at: fieldIndex
	]
]
