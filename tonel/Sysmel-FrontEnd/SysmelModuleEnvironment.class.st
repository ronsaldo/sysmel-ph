Class {
	#name : 'SysmelModuleEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'module'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SysmelModuleEnvironment >> getModule [
	^ module
]

{ #category : 'accessing' }
SysmelModuleEnvironment >> module [

	^ module
]

{ #category : 'accessing' }
SysmelModuleEnvironment >> module: anObject [

	module := anObject
]
