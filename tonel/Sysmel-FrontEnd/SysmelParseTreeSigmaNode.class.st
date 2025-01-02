Class {
	#name : 'SysmelParseTreeSigmaNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'arguments',
		'isVariadic',
		'body'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeSigmaNode >> accept: visitor [
	^ visitor visitSigmaNode: self
]

{ #category : 'accessing' }
SysmelParseTreeSigmaNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelParseTreeSigmaNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SysmelParseTreeSigmaNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreeSigmaNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelParseTreeSigmaNode >> isVariadic [

	^ isVariadic
]

{ #category : 'accessing' }
SysmelParseTreeSigmaNode >> isVariadic: anObject [

	isVariadic := anObject
]
