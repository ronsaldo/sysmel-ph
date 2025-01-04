Class {
	#name : 'SymbolFixpointBinding',
	#superclass : 'SymbolBinding',
	#instVars : [
		'typeExpression',
		'ownerFixpointValue'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SymbolFixpointBinding >> evaluateASGIn: evalSourcePosition [
	self assert: ownerFixpointValue isNotNil.
	^ ownerFixpointValue
]

{ #category : 'accessing' }
SymbolFixpointBinding >> ownerFixpointValue [

	^ ownerFixpointValue
]

{ #category : 'accessing' }
SymbolFixpointBinding >> ownerFixpointValue: anObject [

	ownerFixpointValue := anObject
]

{ #category : 'accessing' }
SymbolFixpointBinding >> typeExpression [

	^ typeExpression
]

{ #category : 'accessing' }
SymbolFixpointBinding >> typeExpression: anObject [

	typeExpression := anObject
]
