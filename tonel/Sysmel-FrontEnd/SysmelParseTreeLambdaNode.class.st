Class {
	#name : 'SysmelParseTreeLambdaNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'nameExpression',
		'arguments',
		'isVariadic',
		'resultType',
		'body',
		'callingConvention',
		'isFixpoint'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeLambdaNode >> accept: visitor [
	^ visitor visitLambdaNode: self
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> callingConvention [

	^ callingConvention
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> callingConvention: anObject [

	callingConvention := anObject
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> isFixpoint [

	^ isFixpoint
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> isFixpoint: anObject [

	isFixpoint := anObject
]

{ #category : 'testing' }
SysmelParseTreeLambdaNode >> isLambdaNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> isVariadic [

	^ isVariadic
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> isVariadic: anObject [

	isVariadic := anObject
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> nameExpression [

	^ nameExpression
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> nameExpression: anObject [

	nameExpression := anObject
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> resultType [

	^ resultType
]

{ #category : 'accessing' }
SysmelParseTreeLambdaNode >> resultType: anObject [

	resultType := anObject
]
