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
	self importIntrinsicValues.
	self primitiveGlobalMacros.
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

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> importIntrinsicValues [
	self addSymbol: #false valueBinding: false.
	self addSymbol: #true valueBinding: true.
	self addSymbol: #void valueBinding: SysmelVoidType uniqueInstance.
	self addSymbol: #Void valueBinding: SysmelVoidType.
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> primitiveGlobalMacros [
	self addPrimitiveGlobalMacro: #if:then:else:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #condition -> SysmelParseTreeNode .
			#trueResult -> SysmelParseTreeNode.
			#falseResult -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :condition :trueAction :falseAction |
			SysmelParseTreeIfConditionNode new
				sourcePosition: macroContext sourcePosition;
				condition: condition;
				trueResult: trueAction;
				falseResult: falseAction;
				yourself.
		]
]
