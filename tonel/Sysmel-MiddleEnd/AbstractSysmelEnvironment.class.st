Class {
	#name : 'AbstractSysmelEnvironment',
	#superclass : 'Object',
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'testing' }
AbstractSysmelEnvironment class >> isAbstract [
	^ self == AbstractSysmelEnvironment
]

{ #category : 'as yet unclassified' }
AbstractSysmelEnvironment >> getModule [
	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
AbstractSysmelEnvironment >> getNamespace [
	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
AbstractSysmelEnvironment >> lookupRecursively: symbol [
	self subclassResponsibility
]
