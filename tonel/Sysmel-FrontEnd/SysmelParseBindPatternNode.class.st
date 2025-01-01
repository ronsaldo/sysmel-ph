Class {
	#name : 'SysmelParseBindPatternNode',
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
SysmelParseBindPatternNode >> accept: visitor [
	^ visitor visitBindPatternNode: self
]

{ #category : 'accessing' }
SysmelParseBindPatternNode >> pattern [

	^ pattern
]

{ #category : 'accessing' }
SysmelParseBindPatternNode >> pattern: anObject [

	pattern := anObject
]

{ #category : 'accessing' }
SysmelParseBindPatternNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelParseBindPatternNode >> value: anObject [

	value := anObject
]
