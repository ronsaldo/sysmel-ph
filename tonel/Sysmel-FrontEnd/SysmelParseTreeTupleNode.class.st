Class {
	#name : 'SysmelParseTreeTupleNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeTupleNode >> accept: visitor [
	^ visitor visitTupleNode: self
]

{ #category : 'accessing' }
SysmelParseTreeTupleNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelParseTreeTupleNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SysmelParseTreeTupleNode >> isTupleNode [
	^ true
]
