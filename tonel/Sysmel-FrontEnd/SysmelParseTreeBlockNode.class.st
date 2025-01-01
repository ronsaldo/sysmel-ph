Class {
	#name : 'SysmelParseTreeBlockNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'functionalType',
		'body'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeBlockNode >> accept: visitor [
	^ visitor visitBlockNode: self
]

{ #category : 'accessing' }
SysmelParseTreeBlockNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelParseTreeBlockNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelParseTreeBlockNode >> functionalType [

	^ functionalType
]

{ #category : 'accessing' }
SysmelParseTreeBlockNode >> functionalType: anObject [

	functionalType := anObject
]

{ #category : 'visiting' }
SysmelParseTreeBlockNode >> isBlockNode [
	^ true
]
