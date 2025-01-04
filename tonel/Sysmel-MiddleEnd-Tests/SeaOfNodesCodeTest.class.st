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
SeaOfNodesCodeTest >> testFactorial [
	| seaOfNodes factorialFunction factorialResult |
	seaOfNodes := self parseAndCompileString: ':factorial(:(Integer)n :: Integer) := {
    if: n <= 0
    then: 1
    else: factorial(n-1)*n
}.'.
	factorialFunction := seaOfNodes evaluateWithArguments: #().
	factorialResult := factorialFunction evaluateWithArguments: #(10).
	self halt.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testIfThenElse [
	| seaOfNodes |
	seaOfNodes := self parseAndCompileString: 'if: true then: 1u32 else: 0u32'.
	self assert: seaOfNodes regions size equals: 4.
	self assert: seaOfNodes instructions size equals: 10.
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
