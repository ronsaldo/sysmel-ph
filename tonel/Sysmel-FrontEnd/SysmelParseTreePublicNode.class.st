Class {
	#name : 'SysmelParseTreePublicNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'exportedObject'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreePublicNode >> accept: visitor [
	^ visitor visitPublicNode: self
]

{ #category : 'accessing' }
SysmelParseTreePublicNode >> exportedObject [

	^ exportedObject
]

{ #category : 'accessing' }
SysmelParseTreePublicNode >> exportedObject: anObject [

	exportedObject := anObject
]

{ #category : 'testing' }
SysmelParseTreePublicNode >> isPublicNode [
	^ true
]
