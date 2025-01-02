Class {
	#name : 'SymbolFixpointBinding',
	#superclass : 'SymbolBinding',
	#instVars : [
		'typeExpression'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SymbolFixpointBinding >> evaluateASGIn: evalSourcePosition [
	^ self halt
]

{ #category : 'accessing' }
SymbolFixpointBinding >> typeExpression [

	^ typeExpression
]

{ #category : 'accessing' }
SymbolFixpointBinding >> typeExpression: anObject [

	typeExpression := anObject
]
