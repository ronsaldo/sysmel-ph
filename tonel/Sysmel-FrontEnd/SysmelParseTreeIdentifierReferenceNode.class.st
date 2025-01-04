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

{ #category : 'converting' }
SysmelParseTreeIdentifierReferenceNode >> asChainOfUnaryIdentifiers [
	^ { name }
]

{ #category : 'testing' }
SysmelParseTreeIdentifierReferenceNode >> isIdentifierReferenceNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeIdentifierReferenceNode >> name [

	^ name
]

{ #category : 'accessing' }
SysmelParseTreeIdentifierReferenceNode >> name: anObject [

	name := anObject
]
