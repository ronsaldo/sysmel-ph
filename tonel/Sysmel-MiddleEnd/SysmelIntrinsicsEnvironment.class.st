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
	self primitiveTypes.
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
		].
		self addPrimitiveGlobalMacro: #if:then:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #condition -> SysmelParseTreeNode .
			#trueResult -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :condition :trueAction |
			SysmelParseTreeIfConditionNode new
				sourcePosition: macroContext sourcePosition;
				condition: condition;
				trueResult: trueAction;
				yourself.
		].
		self addPrimitiveGlobalMacro: #while:do:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #condition -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :condition :body |
			SysmelParseTreeWhileLoopNode new
				sourcePosition: macroContext sourcePosition;
				condition: condition;
				body: body;
				yourself.
		].
		self addPrimitiveGlobalMacro: #while:do:continueWith:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #condition -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode .
			#continueAction -> SysmelParseTreeNode}
			resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :condition :body :continueExpression |
			SysmelParseTreeWhileLoopNode new
				sourcePosition: macroContext sourcePosition;
				condition: condition;
				body: body;
				continueExpression: continueExpression;
				yourself.
		].
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> primitiveTypes [
	"PrimitiveIntegers"
	{#UInt8 . #Int64 . #Char16 . #Int16 . #UInt32 . #Int8 . #UInt64 . #Char8 . #Char32 . #UInt16 . #Int32} do: [ :eachTypeName |
		| eachPrimitiveType|
		eachPrimitiveType := SysmelType perform: eachTypeName.
		self addSymbol: eachPrimitiveType valueBinding: eachPrimitiveType.
	]
]
