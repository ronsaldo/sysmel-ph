Class {
	#name : 'SysmelParseTreeWhileLoopNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'condition',
		'body',
		'continueExpression'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeWhileLoopNode >> accept: visitor [
	^ visitor visitWhileLoopNode: self
]

{ #category : 'accessing' }
SysmelParseTreeWhileLoopNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreeWhileLoopNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelParseTreeWhileLoopNode >> condition [

	^ condition
]

{ #category : 'accessing' }
SysmelParseTreeWhileLoopNode >> condition: anObject [

	condition := anObject
]

{ #category : 'accessing' }
SysmelParseTreeWhileLoopNode >> continueExpression [

	^ continueExpression
]

{ #category : 'accessing' }
SysmelParseTreeWhileLoopNode >> continueExpression: anObject [

	continueExpression := anObject
]

{ #category : 'testing' }
SysmelParseTreeWhileLoopNode >> isWhileLoopNode [
	^ true
]
