"
I am a sysmel parse tree node.
"
Class {
	#name : 'SysmelParseTreeNode',
	#superclass : 'Object',
	#instVars : [
		'sourcePosition'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeNode >> accept: visitor [
	^ self subclassResponsibility
]

{ #category : 'converting' }
SysmelParseTreeNode >> asMessageSendCascadeReceiverAndFirstMessage [
	^ { self . nil }
]

{ #category : 'testing' }
SysmelParseTreeNode >> isApplicationNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isAssignmentNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isAssociationNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isBinaryExpressionSequenceNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isBindPatternNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isBindableNameNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isBlockNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isDictionaryNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isFunctionalDependentTypeNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isIdentifierReferenceNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isIfConditionNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLexicalBlockNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralCharacterNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralFloatNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralFunctionNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralIntegerNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralStringNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isLiteralSymbolNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isMessageCascadeMessageNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isMessageCascadeNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isMessageSendNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isParseErrorNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isQuasiQuoteNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isQuasiUnquoteNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isQuoteNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isSequenceNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isSpliceNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isTupleNode [
	^ false
]

{ #category : 'testing' }
SysmelParseTreeNode >> isWhileLoopNode [
	^ false
]

{ #category : 'accessing' }
SysmelParseTreeNode >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelParseTreeNode >> sourcePosition: anObject [

	sourcePosition := anObject
]
