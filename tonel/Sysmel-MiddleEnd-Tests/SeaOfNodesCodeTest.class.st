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