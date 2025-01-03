Class {
	#name : 'SysmelEvaluationContext',
	#superclass : 'Object',
	#instVars : [
		'instructions',
		'arguments',
		'pc',
		'activationMemory',
		'returnValue',
		'hasReturned'
	],
	#category : 'Sysmel-MiddleEnd-SeaOfNodesGraph',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'SeaOfNodesGraph'
}

{ #category : 'as yet unclassified' }
SysmelEvaluationContext >> allocateActivationMemory [
	activationMemory := Array new: instructions size.
]

{ #category : 'accessing' }
SysmelEvaluationContext >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelEvaluationContext >> arguments: anObject [

	arguments := anObject
]

{ #category : 'as yet unclassified' }
SysmelEvaluationContext >> evaluateNodeValue: node [
	^ activationMemory at: node index
]

{ #category : 'as yet unclassified' }
SysmelEvaluationContext >> evaluateNodesValue: nodes [
	^ nodes collect: [ :each | self evaluateNodeValue: each ]
]

{ #category : 'initialization' }
SysmelEvaluationContext >> hasReturned [
	^ hasReturned
]

{ #category : 'initialization' }
SysmelEvaluationContext >> initialize [
	hasReturned := false
]

{ #category : 'accessing' }
SysmelEvaluationContext >> instructions [

	^ instructions
]

{ #category : 'accessing' }
SysmelEvaluationContext >> instructions: aListOfInstructions [
	instructions := aListOfInstructions.
]

{ #category : 'accessing' }
SysmelEvaluationContext >> pc [

	^ pc
]

{ #category : 'accessing' }
SysmelEvaluationContext >> pc: anObject [

	pc := anObject
]

{ #category : 'initialization' }
SysmelEvaluationContext >> returnValue [
	^ returnValue
]

{ #category : 'initialization' }
SysmelEvaluationContext >> returnValue: aReturnValue [
	returnValue := aReturnValue.
	hasReturned := true.
]

{ #category : 'running' }
SysmelEvaluationContext >> run [
	| instructionCount |
	self allocateActivationMemory.
	instructionCount := instructions size.
	[(1 <= pc and: pc <= instructionCount) and: [hasReturned not]] whileTrue: [
		| instruction |
		instruction := instructions at: pc.
		instruction evaluateWithContext: self.
	].

	^ returnValue 
]

{ #category : 'initialization' }
SysmelEvaluationContext >> setValue: value andAdvancePC: advanceCount [
	activationMemory at: pc put: value.
	^ pc := pc + advanceCount
]
