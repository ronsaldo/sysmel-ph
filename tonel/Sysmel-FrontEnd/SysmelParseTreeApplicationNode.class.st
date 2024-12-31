Class {
	#name : 'SysmelParseTreeApplicationNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'functional',
		'arguments'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeApplicationNode >> accept: visitor [
	^ visitor visitApplicationNode: self
]

{ #category : 'accessing' }
SysmelParseTreeApplicationNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelParseTreeApplicationNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SysmelParseTreeApplicationNode >> functional [

	^ functional
]

{ #category : 'accessing' }
SysmelParseTreeApplicationNode >> functional: anObject [

	functional := anObject
]

{ #category : 'testing' }
SysmelParseTreeApplicationNode >> isApplicationNode [
	^ true
]
