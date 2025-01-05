Class {
	#name : 'SysmelStructType',
	#superclass : 'SysmelTupleType',
	#instVars : [
		'fieldNames',
		'supertype',
		'nameToIndexMap'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'as yet unclassified' }
SysmelStructType >> evaluateASGIn: sourcePosition [
	^ self
]

{ #category : 'accessing' }
SysmelStructType >> fieldNames [

	^ fieldNames
]

{ #category : 'accessing' }
SysmelStructType >> fieldNames: anObject [

	fieldNames := anObject
]

{ #category : 'initialization' }
SysmelStructType >> initialize [
	nameToIndexMap := Dictionary new.
]

{ #category : 'testing' }
SysmelStructType >> isStructType [
	^ true
]

{ #category : 'as yet unclassified' }
SysmelStructType >> nameToIndex: aName [
	^ nameToIndexMap at: aName ifAbsent: [ supertype nameToIndex: aName ]
]

{ #category : 'as yet unclassified' }
SysmelStructType >> namedElements: aListWithAssociations [

	fieldNames := aListWithAssociations collectWithIndex: [ :each :index |
		nameToIndexMap at: each key put: index.
		each key
	].
	elements := aListWithAssociations collect: [ :each | each value ].
]

{ #category : 'accessing' }
SysmelStructType >> supertype [

	^ supertype
]

{ #category : 'accessing' }
SysmelStructType >> supertype: anObject [

	supertype := anObject
]
