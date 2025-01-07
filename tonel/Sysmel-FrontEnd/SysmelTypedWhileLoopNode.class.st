Class {
	#name : 'SysmelTypedWhileLoopNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'condition',
		'body',
		'continueExpression'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedWhileLoopNode >> accept: visitor [
	^ visitor visitWhileLoopNode: self
]

{ #category : 'accessing' }
SysmelTypedWhileLoopNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelTypedWhileLoopNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelTypedWhileLoopNode >> condition [

	^ condition
]

{ #category : 'accessing' }
SysmelTypedWhileLoopNode >> condition: anObject [

	condition := anObject
]

{ #category : 'accessing' }
SysmelTypedWhileLoopNode >> continueExpression [

	^ continueExpression
]

{ #category : 'accessing' }
SysmelTypedWhileLoopNode >> continueExpression: anObject [

	continueExpression := anObject
]
