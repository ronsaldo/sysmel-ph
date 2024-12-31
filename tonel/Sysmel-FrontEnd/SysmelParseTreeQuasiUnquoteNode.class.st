Class {
	#name : 'SysmelParseTreeQuasiUnquoteNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'term'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeQuasiUnquoteNode >> accept: visitor [
	^ visitor visitQuasiUnquoteNode: self
]

{ #category : 'testing' }
SysmelParseTreeQuasiUnquoteNode >> isQuasiUnquoteNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeQuasiUnquoteNode >> term [

	^ term
]

{ #category : 'accessing' }
SysmelParseTreeQuasiUnquoteNode >> term: anObject [

	term := anObject
]
