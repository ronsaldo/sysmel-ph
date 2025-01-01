Class {
	#name : 'SysmelParseTreeLexicalBlockNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'body'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLexicalBlockNode >> accept: visitor [
	^ visitor visitLexicalBlockNode: self
]

{ #category : 'accessing' }
SysmelParseTreeLexicalBlockNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreeLexicalBlockNode >> body: anObject [

	body := anObject
]

{ #category : 'testing' }
SysmelParseTreeLexicalBlockNode >> isLexicalBlockNode [
	^ true
]
