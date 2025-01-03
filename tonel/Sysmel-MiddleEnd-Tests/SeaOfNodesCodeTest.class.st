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
SeaOfNodesCodeTest >> parseAndEvaluateString: string [
	^ (Sysmel moduleNamed: #Test) parseAndEvaluateString: string.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testConstant [
	| seaOfNodes |
	seaOfNodes := self parseAndEvaluateString: '42'.
	self assert: seaOfNodes dataResult type equals: Integer.
	self assert: seaOfNodes dataResult value equals: 42.
	self assert: seaOfNodes startingRegion isEmpty.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testEmpty [
	| seaOfNodes |
	seaOfNodes := self parseAndEvaluateString: ''.
	self assert: seaOfNodes dataResult type isVoidType.
	self assert: seaOfNodes startingRegion isEmpty.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testIfThenElse [
	| seaOfNodes |
	seaOfNodes := self parseAndEvaluateString: 'if: true then: 1u32 else: 0u32'.
	self assert: seaOfNodes dataResult type equals: SysmelType UInt32.
	self halt.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testPrimitiveIntegers [
	| seaOfNodes |
	seaOfNodes := self parseAndEvaluateString: '56u32'.
	self assert: seaOfNodes dataResult type equals: SysmelType UInt32.
	self assert: seaOfNodes startingRegion isEmpty.
]

{ #category : 'tests' }
SeaOfNodesCodeTest >> testPrimitiveIntegersArithmetic [
	| seaOfNodes |
	seaOfNodes := self parseAndEvaluateString: '56u32 + 48u32'.
	self assert: seaOfNodes dataResult type equals: SysmelType UInt32.
	self assert: seaOfNodes startingRegion isEmpty.
]
