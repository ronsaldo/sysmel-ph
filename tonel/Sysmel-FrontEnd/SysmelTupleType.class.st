Class {
	#name : 'SysmelTupleType',
	#superclass : 'SysmelType',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelTupleType >> defaultValue [
	^ SysmelPrimitiveTupleTypeValue new
		value: (elements collect: [:each | each defaultValue]);
		primitiveType: self;
		yourself
]

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
