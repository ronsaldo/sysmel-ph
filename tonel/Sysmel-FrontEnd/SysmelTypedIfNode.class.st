Class {
	#name : 'SysmelTypedIfNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'condition',
		'trueResult',
		'falseResult'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedIfNode >> accept: visitor [
	^ visitor visitIfNode: self
]

{ #category : 'accessing' }
SysmelTypedIfNode >> condition [

	^ condition
]

{ #category : 'accessing' }
SysmelTypedIfNode >> condition: anObject [

	condition := anObject
]

{ #category : 'accessing' }
SysmelTypedIfNode >> falseResult [

	^ falseResult
]

{ #category : 'accessing' }
SysmelTypedIfNode >> falseResult: anObject [

	falseResult := anObject
]

{ #category : 'testing' }
SysmelTypedIfNode >> isIfNode [
	^ true
]

{ #category : 'accessing' }
SysmelTypedIfNode >> trueResult [

	^ trueResult
]

{ #category : 'accessing' }
SysmelTypedIfNode >> trueResult: anObject [

	trueResult := anObject
]
