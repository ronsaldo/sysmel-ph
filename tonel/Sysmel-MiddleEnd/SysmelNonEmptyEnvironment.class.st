Class {
	#name : 'SysmelNonEmptyEnvironment',
	#superclass : 'AbstractSysmelEnvironment',
	#instVars : [
		'sourcePosition',
		'parent',
		'localSymbols'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
SysmelNonEmptyEnvironment class >> parent: aParentEnvironment [
	^ self new parent: aParentEnvironment; yourself
]

{ #category : 'adding' }
SysmelNonEmptyEnvironment >> addPrimitiveGlobalMacro: macroName type: macroType implementation: implementation [
	self addSymbol: macroName valueBinding: (PrimitiveMacroMethod new type: macroType; implementation: implementation; yourself)
]

{ #category : 'adding' }
SysmelNonEmptyEnvironment >> addPrimitiveGlobalMethod: methodName type: methodType implementation: implementation [
	self addSymbol: methodName valueBinding: (PrimitiveMacroMethod new type: methodType; implementation: implementation; yourself)
]

{ #category : 'adding' }
SysmelNonEmptyEnvironment >> addSymbol: symbol valueBinding: value [
	localSymbols at: symbol put: (SymbolValueBinding new name: symbol; value: value; yourself)
]

{ #category : 'as yet unclassified' }
SysmelNonEmptyEnvironment >> getModule [
	^ parent getModule
]

{ #category : 'as yet unclassified' }
SysmelNonEmptyEnvironment >> getNamespace [
	^ parent getNamespace
]

{ #category : 'initialization' }
SysmelNonEmptyEnvironment >> initialize [
	super initialize.
	localSymbols := Dictionary new.
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> localSymbols [

	^ localSymbols
]

{ #category : 'as yet unclassified' }
SysmelNonEmptyEnvironment >> lookupLocalSymbol: symbol [
	^ (localSymbols includesKey: symbol)
		ifTrue: [ localSymbols at: symbol ]
		ifFalse: [ nil ]
]

{ #category : 'as yet unclassified' }
SysmelNonEmptyEnvironment >> lookupRecursively: symbol [
	(self lookupLocalSymbol: symbol) ifNotNil: [ :binding | ^ binding ].
	^ parent lookupRecursively: symbol
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> parent [

	^ parent
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> parent: anObject [

	parent := anObject
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelNonEmptyEnvironment >> sourcePosition: anObject [

	sourcePosition := anObject
]
