Class {
	#name : 'SysmelParseTreeIdentifierReferenceNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'name'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeIdentifierReferenceNode >> accept: visitor [
	^ visitor visitIdentifierReferenceNode: self
]
