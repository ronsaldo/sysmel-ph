Class {
	#name : 'SysmelTypedGraphNodeVisitor',
	#superclass : 'Object',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitArgumentNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelTypedGraphNodeVisitor >> visitLiteralNode: node [
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
SysmelTypedGraphNodeVisitor >> visitSequenceNode: node [
	self subclassResponsibility
]
