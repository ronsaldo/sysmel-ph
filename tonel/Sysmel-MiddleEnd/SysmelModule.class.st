Class {
	#name : 'SysmelModule',
	#superclass : 'SysmelProgramEntity',
	#instVars : [
		'name',
		'globalNamespace',
		'importedModules',
		'basicEnvironment',
		'empty',
		'intrinsicsEnvironment',
		'moduleEnvironment',
		'namespaceEnvironment'
	],
	#category : 'Sysmel-MiddleEnd-Module',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Module'
}

{ #category : 'instance creation' }
SysmelModule class >> named: aName [
	^ self basicNew initializeWithName: aName
]

{ #category : 'as yet unclassified' }
SysmelModule >> getOrCreateBasicEnvironment [
	basicEnvironment ifNotNil: [ ^ basicEnvironment ].
	
	empty := SysmelEmptyEnvironment new.
	intrinsicsEnvironment := SysmelIntrinsicsEnvironment parent: empty.
	moduleEnvironment := (SysmelModuleEnvironment parent: intrinsicsEnvironment) module: self.
	namespaceEnvironment := (SysmelNamespaceEnvironment parent: moduleEnvironment) namespace: globalNamespace.
	^ basicEnvironment := namespaceEnvironment
	
]

{ #category : 'accessing' }
SysmelModule >> globalNamespace [

	^ globalNamespace
]

{ #category : 'accessing' }
SysmelModule >> importedModules [

	^ importedModules
]

{ #category : 'initialization' }
SysmelModule >> initializeWithName: aName [
	name := aName asSymbol.
	globalNamespace := SysmelNamespace new
		name: #__global;
		yourself.
	importedModules := OrderedCollection new.
	
]

{ #category : 'as yet unclassified' }
SysmelModule >> makeEnvironmentFor: ast [
	^ (SysmelLexicalEnvironment parent: self getOrCreateBasicEnvironment)
		sourcePosition: ast sourcePosition;
		yourself
]