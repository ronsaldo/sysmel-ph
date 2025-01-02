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

{ #category : 'testing' }
SysmelParseTreeTupleNode >> parseAndUnpackArgumentsPattern [
	| isExistential isVariadic |
	(self elements allSatisfy: [ :each | each isBindableNameNode ]) ifFalse: [
		self error: 'Tuple argument pattern must be filled with bindable name nodes'
	].

	isExistential := false.
	isVariadic := false.
	
	^ { self elements . isExistential . isVariadic }
]
