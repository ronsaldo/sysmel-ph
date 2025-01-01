Class {
	#name : 'SysmelParseTreeDictionaryNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeDictionaryNode >> accept: visitor [
	^ visitor visitDictionaryNode: self
]

{ #category : 'accessing' }
SysmelParseTreeDictionaryNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelParseTreeDictionaryNode >> elements: anObject [

	elements := anObject
]

{ #category : 'visiting' }
SysmelParseTreeDictionaryNode >> isDictionaryNode [
	^ true
]
