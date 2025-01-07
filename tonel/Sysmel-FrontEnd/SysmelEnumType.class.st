Class {
	#name : 'SysmelEnumType',
	#superclass : 'SysmelType',
	#instVars : [
		'baseType',
		'elements',
		'elementDictionary'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelEnumType >> baseType [

	^ baseType
]

{ #category : 'accessing' }
SysmelEnumType >> baseType: anObject [

	baseType := anObject
]

{ #category : 'accessing' }
SysmelEnumType >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelEnumType >> elements: aListOfAssociations [
	elements := aListOfAssociations.
	elementDictionary := Dictionary newFrom: aListOfAssociations.
]

{ #category : 'as yet unclassified' }
SysmelEnumType >> evaluateASGIn: sourcePosition [
	^ self
]

{ #category : 'testing' }
SysmelEnumType >> isSysmelNamespaceLike [
	^ true
]

{ #category : 'testing' }
SysmelEnumType >> lookChildNamed: enumName [
	^ elementDictionary at: enumName ifAbsent: [ nil ]
]

{ #category : 'accessing' }
SysmelEnumType >> type [
	^ SysmelTypeUniverse withIndex: 0
]
