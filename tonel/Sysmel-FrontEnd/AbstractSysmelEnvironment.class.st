Class {
	#name : 'AbstractSysmelEnvironment',
	#superclass : 'Object',
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
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
