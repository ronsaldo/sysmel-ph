Class {
	#name : 'SysmelParseTreeSpliceNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'term'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeSpliceNode >> accept: visitor [
	^ visitor visitSpliceNode: self
]

{ #category : 'visiting' }
SysmelParseTreeSpliceNode >> isSpliceNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeSpliceNode >> term [

	^ term
]

{ #category : 'accessing' }
SysmelParseTreeSpliceNode >> term: anObject [

	term := anObject
]
