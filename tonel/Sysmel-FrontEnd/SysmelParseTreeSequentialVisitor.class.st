Class {
	#name : 'SysmelParseTreeSequentialVisitor',
	#superclass : 'SysmelParseTreeVisitor',
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitApplicationNode: node [
	self visitNode: node functional.
	self visitNodes: node arguments.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitAssignmentNode: node [
	self visitNode: node store.
	self visitNode: node value.
]

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
SysmelParseTreeSequentialVisitor >> visitBindPatternNode: node [
	self visitNode: node pattern.
	self visitNode: node value.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitBindableNameNode: node [
	self visitOptionalNode: node typeExpression.
	self visitOptionalNode: node nameExpression.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitBlockNode: node [
	self visitNode: node functionalType .
	self visitNode: node body.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitDictionaryNode: node [
	self visitNodes: node elements
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitEnumNode: node [
	self visitNode: node baseType.
	self visitNode: node elements.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitFunctionNode: node [
	self visitOptionalNode: node nameExpression.
	self visitNode: node functionalType.
	self visitNode: node body
	
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitFunctionalDependentNode: node [
	self visitOptionalNode: node argumentPattern.
	self visitOptionalNode: node resultType.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitIdentifierReferenceNode: node [
	"By default do nothing here."
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitIfConditionNode: node [
	self visitNode: node condition.
	self visitOptionalNode: node trueResult.
	self visitOptionalNode: node falseResult.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitLambdaNode: node [
	self halt
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitLexicalBlockNode: node [
	self visitNode: node body
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
SysmelParseTreeSequentialVisitor >> visitLiteralFunctionNode: node [
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
SysmelParseTreeSequentialVisitor >> visitMessageCascadeMessageNode: node [
	self visitNode: node selector.
	self visitNodes: node arguments.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitMessageCascadeNode: node [
	self visitNode: node receiver.
	self visitNodes: node messages
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitMessageSendNode: node [
	self visitOptionalNode: node receiver.
	self visitNode: node selector.
	self visitNodes: node arguments
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitNamespaceNode: node [
	self visitNode: node body.
	
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitParseErrorNode: node [
	node innerNodes do: [ :each | self visitNode: each ]
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitPiNode: node [
	self visitNodes: node arguments.
	self visitOptionalNode: node body.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitPublicNode: node [
	self visitNode: node body
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitQuasiQuoteNode: node [
	self visitNode: node term
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitQuasiUnquoteNode: node [
	self visitNode: node term
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitQuoteNode: node [
	self visitNode: node term
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitSequenceNode: node [
	self visitNodes: node elements
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitSigmaNode: node [
	self visitNodes: node arguments.
	self visitOptionalNode: node body.
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitSpliceNode: node [
	self visitNode: node term
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitTupleNode: node [
	self visitNodes: node elements
]

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitWhileLoopNode: node [
	self visitOptionalNode: node condition.
	self visitOptionalNode: node body.
	self visitOptionalNode: node continueExpression.
]
