Class {
	#name : 'SysmelPointerLikeType',
	#superclass : 'SysmelType',
	#instVars : [
		'baseType'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
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
