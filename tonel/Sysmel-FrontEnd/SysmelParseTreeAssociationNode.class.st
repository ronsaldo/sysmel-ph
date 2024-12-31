Class {
	#name : 'SysmelParseTreeAssociationNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'key',
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeAssociationNode >> accept: visitor [
	^ visitor visitAssociationNode: self
]

{ #category : 'testing' }
SysmelParseTreeAssociationNode >> isAssociationNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeAssociationNode >> key [

	^ key
]

{ #category : 'accessing' }
SysmelParseTreeAssociationNode >> key: anObject [

	key := anObject
]

{ #category : 'accessing' }
SysmelParseTreeAssociationNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelParseTreeAssociationNode >> value: anObject [

	value := anObject
]
