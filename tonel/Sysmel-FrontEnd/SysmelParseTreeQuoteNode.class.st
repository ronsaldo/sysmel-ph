Class {
	#name : 'SysmelParseTreeQuoteNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'term'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeQuoteNode >> accept: visitor [
	^ visitor visitQuoteNode: self
]

{ #category : 'testing' }
SysmelParseTreeQuoteNode >> isQuoteNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeQuoteNode >> term [

	^ term
]

{ #category : 'accessing' }
SysmelParseTreeQuoteNode >> term: anObject [

	term := anObject
]
