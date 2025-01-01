Class {
	#name : 'SysmelIntrinsicsEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> buildIntrinsicSymbols [
	self importIntrinsicClasses.
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> importIntrinsicClasses [
	{ ProtoObject . Object . UndefinedObject . Boolean . True . False . Behavior.
	ClassDescription . Class . Metaclass . MacroContext.
	PrimitiveMacroMethod . PrimitiveMethod . Magnitude . Character.
	Number . Integer . Float . Collection . SequenceableCollection.
	ArrayedCollection . Array . ByteArray . String . Symbol . Stream.
	BinaryFileStream . Stdio . TestCase} do: [ :eachClass |
		self addSymbol: eachClass name valueBinding: eachClass
	]
]
