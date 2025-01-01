Class {
	#name : 'SysmelParseTreeIfConditionNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'condition',
		'trueResult',
		'falseResult'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeIfConditionNode >> accept: visitor [
	^ visitor visitIfConditionNode: self
]

{ #category : 'accessing' }
SysmelParseTreeIfConditionNode >> condition [

	^ condition
]

{ #category : 'accessing' }
SysmelParseTreeIfConditionNode >> condition: anObject [

	condition := anObject
]

{ #category : 'accessing' }
SysmelParseTreeIfConditionNode >> falseResult [

	^ falseResult
]

{ #category : 'accessing' }
SysmelParseTreeIfConditionNode >> falseResult: anObject [

	falseResult := anObject
]

{ #category : 'testing' }
SysmelParseTreeIfConditionNode >> isIfConditionNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeIfConditionNode >> trueResult [

	^ trueResult
]

{ #category : 'accessing' }
SysmelParseTreeIfConditionNode >> trueResult: anObject [

	trueResult := anObject
]
