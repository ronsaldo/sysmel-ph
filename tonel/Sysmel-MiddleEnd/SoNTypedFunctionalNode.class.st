Class {
	#name : 'SoNTypedFunctionalNode',
	#superclass : 'SoNGraphNode',
	#instVars : [
		'name',
		'type',
		'arguments',
		'isVariadic',
		'captureBindings',
		'body',
		'callingConvention'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'accessing' }
SoNTypedFunctionalNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> arguments: anObject [

	arguments := anObject.
	arguments do: [ :each |each addUser: self ]
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> body [

	^ body
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> body: anObject [

	body := anObject.
	body addUser: self
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> callingConvention [

	^ callingConvention
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> callingConvention: anObject [

	callingConvention := anObject
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> captureBindings [

	^ captureBindings
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> captureBindings: anObject [

	captureBindings := anObject
]

{ #category : 'as yet unclassified' }
SoNTypedFunctionalNode >> dataDependenciesDo: aBlock [
	captureBindings do: aBlock
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> isVariadic [

	^ isVariadic
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> isVariadic: anObject [

	isVariadic := anObject
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> name [

	^ name
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> type [

	^ type
]

{ #category : 'accessing' }
SoNTypedFunctionalNode >> type: anObject [

	type := anObject
]
