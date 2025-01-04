Class {
	#name : 'SysmelParseTreeNamespaceNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'name',
		'body'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeNamespaceNode >> accept: visitor [
	^ visitor visitNamespaceNode: self
]

{ #category : 'accessing' }
SysmelParseTreeNamespaceNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreeNamespaceNode >> body: anObject [

	body := anObject
]

{ #category : 'testing' }
SysmelParseTreeNamespaceNode >> isNamespaceNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeNamespaceNode >> name [

	^ name
]

{ #category : 'accessing' }
SysmelParseTreeNamespaceNode >> name: anObject [

	name := anObject
]
