Class {
	#name : 'SysmelTypedGraphNodeVisitor',
	#superclass : 'Object',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitApplicationNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitArgumentNode: node [
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
