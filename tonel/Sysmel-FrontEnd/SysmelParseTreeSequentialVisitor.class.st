Class {
	#name : 'SysmelParseTreeSequentialVisitor',
	#superclass : 'SysmelParseTreeVisitor',
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitAssociationNode: node [
	self visitNode: node key.
	self visitNode: node value.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitBinaryExpressionSequenceNode: node [
	self visitNodes: node elements
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitIdentifierReferenceNode: node [
	"By default do nothing here."
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitLiteralCharacterNode: node [
	"Nothing is required here."
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitLiteralFloatNode: node [
	"Nothing is required here."
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitLiteralIntegerNode: node [
	"Nothing is required here."
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitLiteralStringNode: node [
	"Nothing is required here."
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitLiteralSymbolNode: node [
	"Nothing is required here."
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitParseErrorNode: node [
	node innerNodes do: [ :each | self visitNode: each ]
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitSequenceNode: node [
	self visitNodes: node elements
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitTupleNode: node [
	self visitNodes: node elements
]