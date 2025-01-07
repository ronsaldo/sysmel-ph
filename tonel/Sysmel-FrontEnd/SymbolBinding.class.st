Class {
	#name : 'SymbolBinding',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition',
		'name'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
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

{ #category : 'accessing' }
SymbolBinding >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SymbolBinding >> sourcePosition: anObject [

	sourcePosition := anObject
]
