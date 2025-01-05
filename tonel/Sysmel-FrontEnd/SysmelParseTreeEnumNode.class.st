Class {
	#name : 'SysmelParseTreeEnumNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'name',
		'baseType',
		'elements'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeEnumNode >> accept: visitor [
	^ visitor visitEnumNode: self
]

{ #category : 'accessing' }
SysmelParseTreeEnumNode >> baseType [

	^ baseType
]

{ #category : 'accessing' }
SysmelParseTreeEnumNode >> baseType: anObject [

	baseType := anObject
]

{ #category : 'accessing' }
SysmelParseTreeEnumNode >> elements [

	^ elements
]

{ #category : 'accessing' }
SysmelParseTreeEnumNode >> elements: anObject [

	elements := anObject
]

{ #category : 'testing' }
SysmelParseTreeEnumNode >> isEnumNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeEnumNode >> name [

	^ name
]

{ #category : 'accessing' }
SysmelParseTreeEnumNode >> name: anObject [

	name := anObject
]
