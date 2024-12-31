Class {
	#name : 'SysmelParseTreeQuasiQuoteNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'term'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeQuasiQuoteNode >> accept: visitor [
	^ visitor visitQuasiQuoteNode: self
]

{ #category : 'testing' }
SysmelParseTreeQuasiQuoteNode >> isQuasiQuoteNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeQuasiQuoteNode >> term [

	^ term
]

{ #category : 'accessing' }
SysmelParseTreeQuasiQuoteNode >> term: anObject [

	term := anObject
]
