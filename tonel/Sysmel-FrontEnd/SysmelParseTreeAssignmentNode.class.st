Class {
	#name : 'SysmelParseTreeAssignmentNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'store',
		'value'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeAssignmentNode >> accept: visitor [
	^ visitor visitAssignmentNode: self
]

{ #category : 'testing' }
SysmelParseTreeAssignmentNode >> isAssignmentNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeAssignmentNode >> store [

	^ store
]

{ #category : 'accessing' }
SysmelParseTreeAssignmentNode >> store: anObject [

	store := anObject
]

{ #category : 'accessing' }
SysmelParseTreeAssignmentNode >> value [
	^ value
]

{ #category : 'accessing' }
SysmelParseTreeAssignmentNode >> value: anObject [

	value := anObject
]
