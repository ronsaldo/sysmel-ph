"
I am a visitor of a parse tree.
"
Class {
	#name : 'SysmelParseTreeVisitor',
	#superclass : 'Object',
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitIdentifierReferenceNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitLiteralCharacterNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitLiteralFloatNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitLiteralIntegerNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitLiteralStringNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitLiteralSymbolNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitNode: aNode [
	^ aNode accept: self
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitParseErrorNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitSequenceNode: node [
	self subclassResponsibility
]
