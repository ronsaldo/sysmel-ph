Class {
	#name : 'SysmelParseTreeErrorNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'errorMessage',
		'innerNodes'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeErrorNode >> accept: visitor [
	^ visitor visitParseErrorNode: self
]

{ #category : 'accessing' }
SysmelParseTreeErrorNode >> errorMessage [

	^ errorMessage
]

{ #category : 'accessing' }
SysmelParseTreeErrorNode >> errorMessage: anObject [

	errorMessage := anObject
]

{ #category : 'initialization' }
SysmelParseTreeErrorNode >> initialize [
	innerNodes := #().
]

{ #category : 'accessing' }
SysmelParseTreeErrorNode >> innerNodes [

	^ innerNodes
]

{ #category : 'accessing' }
SysmelParseTreeErrorNode >> innerNodes: anObject [

	innerNodes := anObject
]

{ #category : 'testing' }
SysmelParseTreeErrorNode >> isParseErrorNode [
	^ true
]
