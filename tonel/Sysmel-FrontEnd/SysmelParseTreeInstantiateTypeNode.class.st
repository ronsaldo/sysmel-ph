Class {
	#name : 'SysmelParseTreeInstantiateTypeNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'type',
		'constructorValues'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeInstantiateTypeNode >> accept: visitor [
	^ visitor visitInstantiateTypeNode: self
]

{ #category : 'accessing' }
SysmelParseTreeInstantiateTypeNode >> constructorValues [

	^ constructorValues
]

{ #category : 'accessing' }
SysmelParseTreeInstantiateTypeNode >> constructorValues: anObject [

	constructorValues := anObject
]

{ #category : 'testing' }
SysmelParseTreeInstantiateTypeNode >> isInstantiateTypeNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeInstantiateTypeNode >> type [

	^ type
]

{ #category : 'accessing' }
SysmelParseTreeInstantiateTypeNode >> type: anObject [

	type := anObject
]
