Class {
	#name : 'SysmelParseTreeStructNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'name',
		'supertype',
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeStructNode >> accept: visitor [
	^ visitor visitStructNode: self
]

{ #category : 'accessing' }
SysmelParseTreeStructNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelParseTreeStructNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SysmelParseTreeStructNode >> isStructNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeStructNode >> name [

	^ name
]

{ #category : 'accessing' }
SysmelParseTreeStructNode >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
SysmelParseTreeStructNode >> supertype [

	^ supertype
]

{ #category : 'accessing' }
SysmelParseTreeStructNode >> supertype: anObject [

	supertype := anObject
]
