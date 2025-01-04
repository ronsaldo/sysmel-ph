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
SysmelParseTreeVisitor >> visitApplicationNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitAssignmentNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitAssociationNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitBinaryExpressionSequenceNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitBindPatternNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitBindableNameNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitBlockNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitDictionaryNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitFunctionNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitFunctionalDependentNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitIdentifierReferenceNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitIfConditionNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitLambdaNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitLexicalBlockNode: node [
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
SysmelParseTreeVisitor >> visitLiteralFunctionNode: node [
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
SysmelParseTreeVisitor >> visitMessageCascadeMessageNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitMessageCascadeNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitMessageSendNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitNamespaceNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitNode: aNode [
	^ aNode accept: self
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitNodes: aCollectionOfNode [
	aCollectionOfNode do: [ :each | self visitNode: each ]
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitOptionalNode: aNode [
	aNode ifNotNil: [ ^ self visitNode: aNode ]
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitParseErrorNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitPiNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitPublicNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitQuasiQuoteNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitQuasiUnquoteNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitQuoteNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitSequenceNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitSigmaNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitSpliceNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitTupleNode: node [
	self subclassResponsibility
]

{ #category : 'visiting' }
SysmelParseTreeVisitor >> visitWhileLoopNode: node [
	self subclassResponsibility
]
