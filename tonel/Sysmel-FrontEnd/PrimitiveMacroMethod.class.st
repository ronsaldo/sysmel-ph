Class {
	#name : 'PrimitiveMacroMethod',
	#superclass : 'Object',
	#instVars : [
		'type',
		'implementation'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
PrimitiveMacroMethod >> evaluateWithContext: macroContext andArguments: arguments [
	^ implementation valueWithArguments: { macroContext } , arguments
]

{ #category : 'accessing' }
PrimitiveMacroMethod >> implementation [

	^ implementation
]

{ #category : 'accessing' }
PrimitiveMacroMethod >> implementation: anObject [

	implementation := anObject
]

{ #category : 'testing' }
PrimitiveMacroMethod >> isSysmelMacro [
	^ true
]

{ #category : 'accessing' }
PrimitiveMacroMethod >> type [

	^ type
]

{ #category : 'accessing' }
PrimitiveMacroMethod >> type: anObject [

	type := anObject
]
