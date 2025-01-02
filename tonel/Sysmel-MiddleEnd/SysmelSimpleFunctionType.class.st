Class {
	#name : 'SysmelSimpleFunctionType',
	#superclass : 'SysmelType',
	#instVars : [
		'argumentTypes',
		'argumentNames',
		'resultType'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'as yet unclassified' }
SysmelSimpleFunctionType class >> withArguments: arguments resultType: resultType [
	^ self new initializeWithArguments: arguments resultType: resultType
]

{ #category : 'accessing' }
SysmelSimpleFunctionType >> argumentNames [

	^ argumentNames
]

{ #category : 'accessing' }
SysmelSimpleFunctionType >> argumentTypes [

	^ argumentTypes
]

{ #category : 'initialization' }
SysmelSimpleFunctionType >> initializeWithArguments: argumentAndNames resultType: theResult [
	argumentNames := argumentAndNames collect: [ :each | each key ].
	argumentTypes := argumentAndNames collect: [ :each | each value ].

	resultType := theResult
]

{ #category : 'accessing' }
SysmelSimpleFunctionType >> resultType [

	^ resultType
]
