Class {
	#name : 'SysmelNamespace',
	#superclass : 'SysmelProgramEntity',
	#instVars : [
		'parent',
		'name',
		'childrenNamespaces',
		'childrenNamespacesMap',
		'exportedChildren',
		'exportedChildrenMap'
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
SysmelNamespace >> exportChild: exportedObject withName: exportedObjectName [
	exportedChildren add: exportedObject.
	exportedChildrenMap at: exportedObjectName put: exportedObject.
]

{ #category : 'as yet unclassified' }
SysmelNamespace >> getOrCreateSubnamespaceNamed: subNamespaceName [
	| subnamespace |
	childrenNamespacesMap at: subNamespaceName ifPresent: [ :found | ^ found ].
	subnamespace := SysmelNamespace new parent: self; name: subNamespaceName; yourself.
	
	childrenNamespaces add: subnamespace.
	childrenNamespacesMap at: subNamespaceName put: subnamespace.
	^ subnamespace
]

{ #category : 'initialization' }
SysmelNamespace >> initialize [
	super initialize.
	childrenNamespaces := OrderedCollection new.
	childrenNamespacesMap := Dictionary new.
	exportedChildren := OrderedCollection new.
	exportedChildrenMap := Dictionary new.
]

{ #category : 'testing' }
SysmelNamespace >> isNamespace [
	^ true
]

{ #category : 'as yet unclassified' }
SysmelNamespace >> lookChildNamed: childName [
	^ childrenNamespacesMap at: childName
		ifAbsent: [ exportedChildrenMap at: childName ifAbsent: [ nil ] ]
]

{ #category : 'accessing' }
SysmelNamespace >> name [

	^ name
]

{ #category : 'accessing' }
SysmelNamespace >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
SysmelNamespace >> parent [

	^ parent
]

{ #category : 'accessing' }
SysmelNamespace >> parent: anObject [

	parent := anObject
]

{ #category : 'printing' }
SysmelNamespace >> printOn: aStream [
	parent ifNotNil: [ parent printOn: aStream. aStream space ].
	aStream nextPutAll: name.
]

{ #category : 'accessing' }
SysmelNamespace >> type [
	^ SysmelNamespaceType uniqueInstance
]
