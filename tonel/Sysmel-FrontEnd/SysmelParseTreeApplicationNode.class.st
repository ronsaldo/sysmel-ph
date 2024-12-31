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

{ #category : 'testing' }
SysmelParseTreeApplicationNode >> isApplicationNode [
	^ true
]
