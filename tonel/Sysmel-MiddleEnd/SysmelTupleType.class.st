Class {
	#name : 'SysmelTupleType',
	#superclass : 'SysmelType',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelTupleType >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelTupleType >> elements: anObject [

	elements := anObject asArray
]

{ #category : 'testing' }
SysmelTupleType >> isTupleType [
	^ true
]

{ #category : 'accessing' }
SysmelTupleType >> makePrimitiveAt: sourcePosition constructorArguments: constructorArguments [
	^ SysmelPrimitiveTupleTypeValue new
		sourcePosition: sourcePosition;
		value: (elements collectWithIndex: [:each :index |
			index <= constructorArguments size
				ifTrue: [ constructorArguments at: index ]
				ifFalse: [ each defaultValue ]
		]) asArray;
		primitiveType: self;
		yourself
		
]
