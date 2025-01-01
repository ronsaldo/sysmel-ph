Class {
	#name : 'PrimitiveMethod',
	#superclass : 'Object',
	#instVars : [
		'type',
		'implementation'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
PrimitiveMethod >> implementation [

	^ implementation
]

{ #category : 'accessing' }
PrimitiveMethod >> implementation: anObject [

	implementation := anObject
]

{ #category : 'accessing' }
PrimitiveMethod >> type [

	^ type
]

{ #category : 'accessing' }
PrimitiveMethod >> type: anObject [

	type := anObject
]
