Class {
	#name : 'SysmelModuleEnvironment',
	#superclass : 'SysmelNonEmptyEnvironment',
	#instVars : [
		'module'
	],
	#category : 'Sysmel-MiddleEnd-Environment',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Environment'
}

{ #category : 'accessing' }
SysmelModuleEnvironment >> module [

	^ module
]

{ #category : 'accessing' }
SysmelModuleEnvironment >> module: anObject [

	module := anObject
]