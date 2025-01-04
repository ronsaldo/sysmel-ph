Class {
	#name : 'SysmelNamespace',
	#superclass : 'SysmelProgramEntity',
	#instVars : [
		'name',
		'childrenNamespaces',
		'childrenNamespacesMap'
	],
	#category : 'Sysmel-MiddleEnd-Module',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Module'
}

{ #category : 'as yet unclassified' }
SysmelNamespace >> evaluateASGIn: sourcePosition [
	^ self
]

{ #category : 'as yet unclassified' }
SysmelNamespace >> getOrCreateSubnamespaceNamed: subNamespaceName [
	| subnamespace |
	childrenNamespacesMap at: subNamespaceName ifPresent: [ :found | ^ found ].
	subnamespace := SysmelNamespace new name: subNamespaceName; yourself.
	
	childrenNamespaces add: subnamespace.
	childrenNamespacesMap at: subNamespaceName put: subnamespace.
	^ subnamespace
]

{ #category : 'initialization' }
SysmelNamespace >> initialize [
	super initialize.
	childrenNamespaces := OrderedCollection new.
	childrenNamespacesMap := Dictionary new.
]

{ #category : 'testing' }
SysmelNamespace >> isNamespace [
	^ true
]

{ #category : 'as yet unclassified' }
SysmelNamespace >> lookChildNamed: childName [
	^ childrenNamespacesMap at: childName ifAbsent: [ nil ]
]

{ #category : 'accessing' }
SysmelNamespace >> name [

	^ name
]

{ #category : 'accessing' }
SysmelNamespace >> name: anObject [

	name := anObject
]
