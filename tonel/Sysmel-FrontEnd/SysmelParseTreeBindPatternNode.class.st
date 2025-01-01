Class {
	#name : 'SysmelParseTreeBindPatternNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'pattern',
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeBindPatternNode >> accept: visitor [
	^ visitor visitBindPatternNode: self
]

{ #category : 'testing' }
SysmelParseTreeBindPatternNode >> isBindPatternNode [
	^ true
]
