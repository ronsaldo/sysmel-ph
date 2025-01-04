Class {
	#name : 'SymbolArgumentBinding',
	#superclass : 'SymbolBinding',
	#instVars : [
		'typeExpression',
		'isImplicit',
		'isExistential',
		'index'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SymbolArgumentBinding >> evaluateASGIn: evalSourcePosition [
	^ SoNArgumentGraphNode new
		sourcePosition: evalSourcePosition;
		type: typeExpression asReducedTypeExpression;
		binding: self;
		isImplicit: isImplicit;
		isExistential: isExistential;
		yourself
]

{ #category : 'accessing' }
SymbolArgumentBinding >> index [

	^ index
]

{ #category : 'accessing' }
SymbolArgumentBinding >> index: anObject [

	index := anObject
]

{ #category : 'accessing' }
SymbolArgumentBinding >> isExistential [

	^ isExistential
]

{ #category : 'accessing' }
SymbolArgumentBinding >> isExistential: anObject [

	isExistential := anObject
]

{ #category : 'accessing' }
SymbolArgumentBinding >> isImplicit [

	^ isImplicit
]

{ #category : 'accessing' }
SymbolArgumentBinding >> isImplicit: anObject [

	isImplicit := anObject
]

{ #category : 'accessing' }
SymbolArgumentBinding >> typeExpression [

	^ typeExpression
]

{ #category : 'accessing' }
SymbolArgumentBinding >> typeExpression: anObject [

	typeExpression := anObject
]
