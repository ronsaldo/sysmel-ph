Class {
	#name : 'SysmelParseTreePiNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'arguments',
		'isVariadic',
		'body',
		'callingConvention'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreePiNode >> accept: visitor [
	^ visitor visitPiNode: self
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> callingConvention [

	^ callingConvention
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> callingConvention: anObject [

	callingConvention := anObject
]

{ #category : 'testing' }
SysmelParseTreePiNode >> isPiNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> isVariadic [

	^ isVariadic
]

{ #category : 'accessing' }
SysmelParseTreePiNode >> isVariadic: anObject [

	isVariadic := anObject
]
