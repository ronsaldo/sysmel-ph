Class {
	#name : 'SysmelTypeUniverse',
	#superclass : 'SysmelType',
	#instVars : [
		'index'
	],
	#classVars : [
		'UniverseIndexCache'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'class initialization' }
SysmelTypeUniverse class >> initialize [
	UniverseIndexCache := Dictionary new.
]

{ #category : 'as yet unclassified' }
SysmelTypeUniverse class >> withIndex: anIndex [
	^ (UniverseIndexCache includes: anIndex)
		ifTrue: [ UniverseIndexCache at: anIndex  ]
		ifFalse: [ UniverseIndexCache at: anIndex put: (self new index: anIndex) ]
	
]

{ #category : 'accessing' }
SysmelTypeUniverse >> index [

	^ index
]

{ #category : 'accessing' }
SysmelTypeUniverse >> index: anObject [

	index := anObject
]

{ #category : 'accessing' }
SysmelTypeUniverse >> type [
	^ self class withIndex: index + 1
]
