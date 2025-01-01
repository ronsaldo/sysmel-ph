Class {
	#name : 'SysmelNamespaceEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'namespace'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
SysmelNamespaceEnvironment >> namespace [

	^ namespace
]

{ #category : 'accessing' }
SysmelNamespaceEnvironment >> namespace: anObject [

	namespace := anObject
]
