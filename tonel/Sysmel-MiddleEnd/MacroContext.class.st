Class {
	#name : 'MacroContext',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition',
		'environment'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
MacroContext >> environment [

	^ environment
]

{ #category : 'accessing' }
MacroContext >> environment: anObject [

	environment := anObject
]

{ #category : 'accessing' }
MacroContext >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
MacroContext >> sourcePosition: anObject [

	sourcePosition := anObject
]
