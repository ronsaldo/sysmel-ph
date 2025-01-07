Class {
	#name : 'SysmelNamespaceEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'namespace'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SysmelNamespaceEnvironment >> getNamespace [
	^ namespace
]

{ #category : 'as yet unclassified' }
SysmelNamespaceEnvironment >> lookupLocalSymbol: symbol [
	^ namespace lookChildNamed: symbol
]

{ #category : 'accessing' }
SysmelNamespaceEnvironment >> namespace [

	^ namespace
]

{ #category : 'accessing' }
SysmelNamespaceEnvironment >> namespace: anObject [

	namespace := anObject
]
