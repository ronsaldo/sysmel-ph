Class {
	#name : 'SysmelParseTreeFunctionalDependentTypeNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'argumentPattern',
		'resultType'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeFunctionalDependentTypeNode >> accept: visitor [
	^ visitor visitFunctionalDependentNode: self
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> argumentPattern [

	^ argumentPattern
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> argumentPattern: anObject [

	argumentPattern := anObject
]

{ #category : 'testing' }
SysmelParseTreeFunctionalDependentTypeNode >> isFunctionalDependentTypeNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> resultType [

	^ resultType
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> resultType: anObject [

	resultType := anObject
]
