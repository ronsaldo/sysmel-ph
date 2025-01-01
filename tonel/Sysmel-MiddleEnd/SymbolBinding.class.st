Class {
	#name : 'SymbolBinding',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SymbolBinding >> evaluateASGIn: node [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
SymbolBinding >> name [

	^ name
]

{ #category : 'accessing' }
SymbolBinding >> name: anObject [

	name := anObject
]
