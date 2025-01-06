"
A SeaOfNodesCodeTest is a test class for testing the behavior of SeaOfNodesCode
"
Class {
	#name : 'SeaOfNodesCodeTest',
	#superclass : 'TestCase',
	#category : 'Sysmel-MiddleEnd-Tests-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd-Tests',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'parsing' }
SeaOfNodesCodeTest >> parseAndCompileString: string [
	^ (Sysmel moduleNamed: #Test) parseAndCompileString: string.
]

{ #category : 'parsing' }
SeaOfNodesCodeTest >> parseAndEvaluateString: string [
	^ (Sysmel moduleNamed: #Test) parseAndEvaluateString: string.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testConstant [
	| seaOfNodes |
	seaOfNodes := self parseAndCompileString: '42'.
	self assert: seaOfNodes regions size equals: 1.
	self assert: seaOfNodes instructions size equals: 2.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testEmpty [
	| seaOfNodes |
	seaOfNodes := self parseAndCompileString: ''.
	self assert: seaOfNodes regions size equals: 1.
	self assert: seaOfNodes instructions size equals: 2.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testEnum [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'enum: MyEnum type: UInt32 with:  #{
    First: 1u32.
    Second:.
    Third:.
}.
	MyEnum Second
'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result value equals: 2.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testFactorial [
	| seaOfNodes factorialFunction factorialResult |
	seaOfNodes := self parseAndCompileString: ':factorial(:(Integer)n :: Integer) := {
    if: n <= 0
    then: 1
    else: factorial(n-1)*n
}.'.
	factorialFunction := seaOfNodes evaluateWithArguments: #().
	factorialResult := factorialFunction evaluateWithArguments: #(100).
	self assert: factorialResult equals: 93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testIfThenElse [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'if: true then: 1u32 else: 0u32'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result equals: 1u32.
	
	seaOfNodes := self parseAndCompileString: 'if: false then: 1u32 else: 0u32'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result equals: 0u32.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testPrimitiveIntegers [
	| seaOfNodes |
	seaOfNodes := self parseAndCompileString: '56u32'.
	self assert: seaOfNodes regions size equals: 1.
	self assert: seaOfNodes instructions size equals: 2
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testPrimitiveIntegersArithmetic [
	| seaOfNodes |
	seaOfNodes := self parseAndCompileString: '56u32 + 8u32'.
	self assert: seaOfNodes regions size equals: 1.
	self assert: seaOfNodes instructions size equals: 2
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testStruct [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'struct: Pair with: #{
		First: Int32.
		Second: Int16
	}.
'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result isStructType .
	self assert: result fieldNames first equals: #First.
	self assert: result fieldNames second equals: #Second.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testStructAccessing [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'struct: Pair with: #{
		First: Int32.
		Second: Int16
	}.
	
	:pair := Pair#{Second: 2i16 . First: 1i32. }.
	pair Second: 8i16.
	pair
'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result isTuplePrimitiveTypeValue .
	self assert: result value first equals: 1i32.
	self assert: result value second equals: 8i16.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testStructInstance [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'struct: Pair with: #{
		First: Int32.
		Second: Int16
	}.
	
	Pair()
'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result isTuplePrimitiveTypeValue .
	self assert: result value first equals: 0i32.
	self assert: result value second equals: 0i16.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testStructInstance2 [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'struct: Pair with: #{
		First: Int32.
		Second: Int16
	}.
	
	Pair(1i32 . 2i16)
'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result isTuplePrimitiveTypeValue .
	self assert: result value first equals: 1i32.
	self assert: result value second equals: 2i16.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testStructInstance3 [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'struct: Pair with: #{
		First: Int32.
		Second: Int16
	}.
	
	Pair#{First: 1i32. Second: 2i16}
'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result isTuplePrimitiveTypeValue .
	self assert: result value first equals: 1i32.
	self assert: result value second equals: 2i16.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testStructInstance4 [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: 'struct: Pair with: #{
		First: Int32.
		Second: Int16
	}.
	
	Pair#{Second: 2i16 . First: 1i32. }
'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result isTuplePrimitiveTypeValue .
	self assert: result value first equals: 1i32.
	self assert: result value second equals: 2i16.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testWhileDo [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: ':!i := 0. while: (i < 10) do: { i := i + 1 }. i'.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result equals: 10.

]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testWhileDoContinueWith [
	| seaOfNodes result |
	seaOfNodes := self parseAndCompileString: ':!i := 0. while: (i < 10) do: {  } continueWith: (i := i + 1). i '.
	result := seaOfNodes evaluateWithArguments: #().
	self assert: result equals: 10.

]
