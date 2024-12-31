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
SysmelParseTreeVisitor >> visitNode: aNode [
	^ aNode accept: self
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitSequenceNode: node [
	self subclassResponsibility
]
