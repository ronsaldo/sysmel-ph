Class {
	#name : 'SysmelPointerLikeType',
	#superclass : 'SysmelType',
	#instVars : [
		'baseType'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'construction' }
SysmelPointerLikeType class >> withBaseType: aBaseType [
	^ self new baseType: aBaseType; yourself
]

{ #category : 'accessing' }
SysmelPointerLikeType >> baseType [

	^ baseType
]

{ #category : 'accessing' }
SysmelPointerLikeType >> baseType: anObject [

	baseType := anObject
]

{ #category : 'testing' }
SysmelPointerLikeType >> isPointerLikeType [
	^ true
]
