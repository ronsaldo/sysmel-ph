Class {
	#name : 'SysmelEmptyEnvironment',
	#superclass : 'AbstractSysmelEnvironment',
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SysmelEmptyEnvironment >> getModule [
	^ nil
]

{ #category : 'as yet unclassified' }
SysmelEmptyEnvironment >> getNamespace [
	^ nil
]

{ #category : 'as yet unclassified' }
SysmelEmptyEnvironment >> lookupLocalSymbol: symbol [
	^ nil
]

{ #category : 'as yet unclassified' }
SysmelEmptyEnvironment >> lookupRecursively: symbol [
	^ nil
]

{ #category : 'accessing' }
SysmelEmptyEnvironment >> parent [
	^ nil
]
