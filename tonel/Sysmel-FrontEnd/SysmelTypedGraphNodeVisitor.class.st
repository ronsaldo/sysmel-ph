Class {
	#name : 'SysmelTypedGraphNodeVisitor',
	#superclass : 'Object',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
SysmelTypedGraphNodeVisitor >> error: errorMessage atSourcePosition: sourcePosition [
	self error: sourcePosition printString, ': ', errorMessage
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitAllocaNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitApplicationNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitArgumentNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitIfNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitLambdaNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitLiteralNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitLoadNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitMessageSendNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitNode: node [
	^ node accept: self
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitOptionalNode: node [
	^ node ifNotNil: [self visitNode: node]
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitPiNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitSequenceNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitSigmaNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitStoreNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitWhileLoopNode: node [
	self subclassResponsibility
]
