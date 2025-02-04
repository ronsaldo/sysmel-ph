Class {
	#name : 'SysmelIntrinsicsEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'loadedFiles'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> buildIntrinsicSymbols [
	self importIntrinsicClasses.
	self importIntrinsicValues.
	self primitiveGlobalMacros.
	self primitiveTypes.
	self namespaceMacro.
	self enumMacro.
	self structMacro.
	self classMacro. "For now keep it as a struct."
	self sourceFileMacros.
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> classMacro [
	self addPrimitiveGlobalMacro: #class:with:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #name -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :nameExpression :elements | 
			| names name |
			names := nameExpression asChainOfUnaryIdentifiers.
			names size ~= 1 ifTrue: [ self error: 'Structs only admit a single token for its name.' ].
			name := names first.
			SysmelParseTreeStructNode new
				sourcePosition: macroContext sourcePosition;
				name: name;
				elements: elements;
				yourself
			].
	self addPrimitiveGlobalMacro: #class:superclass:with:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #name -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :nameExpression :supertype :elements | 
			| names name |
			names := nameExpression asChainOfUnaryIdentifiers.
			names size ~= 1 ifTrue: [ self error: 'Structs only admit a single token for its name.' ].
			name := names first.
			SysmelParseTreeStructNode new
				sourcePosition: macroContext sourcePosition;
				name: name;
				supertype: supertype;
				elements: elements;
				yourself
			].
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> enumMacro [
	self addPrimitiveGlobalMacro: #enum:type:with:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #name -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :nameExpression :baseType :elements | 
			| names name |
			names := nameExpression asChainOfUnaryIdentifiers.
			names size ~= 1 ifTrue: [ self error: 'Enums only admit a single token for its name.' ].
			name := names first.
			SysmelParseTreeEnumNode new
				sourcePosition: macroContext sourcePosition;
				name: name;
				baseType: baseType;
				elements: elements;
				yourself
			].
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> importIntrinsicClasses [
	{ ProtoObject . Object . UndefinedObject . Boolean . True . False . Behavior.
	ClassDescription . Class . Metaclass . MacroContext.
	PrimitiveMacroMethod . PrimitiveMethod . Magnitude . Character.
	Number . Integer . Float . Collection . SequenceableCollection.
	ArrayedCollection .OrderedCollection. Array . ByteArray . String . Symbol . Stream.
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
SysmelIntrinsicsEnvironment >> namespaceMacro [
	self addPrimitiveGlobalMacro: #namespace:definition:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #name -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :nameExpression :body | 
			| names lastNamespaceOrBody |
			names := nameExpression asChainOfUnaryIdentifiers.
			lastNamespaceOrBody := body.
			names reverseDo: [ :eachName |
				lastNamespaceOrBody := SysmelParseTreeNamespaceNode new
					sourcePosition: macroContext sourcePosition;
					name: eachName;
					body: lastNamespaceOrBody;
					yourself.
			].
			lastNamespaceOrBody
		].
	
	self addPrimitiveGlobalMacro: #public:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #exportedObject -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :exportedObject | 
			SysmelParseTreePublicNode new
				sourcePosition: macroContext sourcePosition;
				exportedObject: exportedObject;
				yourself
		].
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
		self addSymbol: eachTypeName valueBinding: eachPrimitiveType.
	]
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> sourceFileMacros [
	loadedFiles := Set new.
	
	self addPrimitiveGlobalMacro: #loadFileOnce:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #filename -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :filenameNode |
			| sourceDirectory sourceName sysmelFrontEnd|
			sourceDirectory := macroContext sourcePosition sourceCode directory asFileReference.
			sourceName := sourceDirectory / filenameNode value.
			sysmelFrontEnd := macroContext environment getModule sysmelFrontEnd.
			sysmelFrontEnd parseAndEvaluateFile: sourceName.
			SysmelParseTreeTupleNode new
				sourcePosition: macroContext sourcePosition;
				elements: #();
				yourself 
		].
]

{ #category : 'as yet unclassified' }
SysmelIntrinsicsEnvironment >> structMacro [
	self addPrimitiveGlobalMacro: #struct:with:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #name -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :nameExpression :elements | 
			| names name |
			names := nameExpression asChainOfUnaryIdentifiers.
			names size ~= 1 ifTrue: [ self error: 'Structs only admit a single token for its name.' ].
			name := names first.
			SysmelParseTreeStructNode new
				sourcePosition: macroContext sourcePosition;
				name: name;
				elements: elements;
				yourself
			].
	self addPrimitiveGlobalMacro: #struct:supertype:with:
		type: (SysmelSimpleFunctionType withArguments: 
		{ #context -> MacroContext .
		  #name -> SysmelParseTreeNode .
			#body -> SysmelParseTreeNode} resultType: SysmelParseTreeNode)
		implementation: [ :macroContext :nameExpression :supertype :elements | 
			| names name |
			names := nameExpression asChainOfUnaryIdentifiers.
			names size ~= 1 ifTrue: [ self error: 'Structs only admit a single token for its name.' ].
			name := names first.
			SysmelParseTreeStructNode new
				sourcePosition: macroContext sourcePosition;
				name: name;
				supertype: supertype;
				elements: elements;
				yourself
			].
]
