Class {
	#name : 'SysmelParseTreeFunctionNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'nameExpression',
		'functionalType',
		'body',
		'isFixpoint'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeFunctionNode >> accept: visitor [
	^ visitor visitFunctionNode: self
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> functionalType [

	^ functionalType
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> functionalType: anObject [

	functionalType := anObject
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> isFixpoint [

	^ isFixpoint
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> isFixpoint: anObject [

	isFixpoint := anObject
]

{ #category : 'testing' }
SysmelParseTreeFunctionNode >> isFunctionNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> nameExpression [

	^ nameExpression
]

{ #category : 'accessing' }
SysmelParseTreeFunctionNode >> nameExpression: anObject [

	nameExpression := anObject
]
