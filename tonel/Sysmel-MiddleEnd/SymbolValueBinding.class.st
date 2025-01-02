Class {
	#name : 'SymbolValueBinding',
	#superclass : 'SymbolBinding',
	#instVars : [
		'value'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SymbolValueBinding >> evaluateASGIn: evalSourcePosition [
	(value isKindOf: SoNGraphNode) ifTrue: [ ^ value ].
	^ SoNLiteralValueGraphNode new
		sourcePosition: evalSourcePosition;
		value: value;
		type: value asSysmelType;
		yourself
]

{ #category : 'accessing' }
SymbolValueBinding >> value [

	^ value
]

{ #category : 'accessing' }
SymbolValueBinding >> value: anObject [

	value := anObject
]
