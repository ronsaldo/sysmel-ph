Class {
	#name : 'SysmelModule',
	#superclass : 'SysmelProgramEntity',
	#instVars : [
		'name',
		'globalNamespace',
		'importedModules'
	],
	#category : 'Sysmel-MiddleEnd-Module',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'Module'
}

{ #category : 'instance creation' }
SysmelModule class >> named: aName [
	^ self basicNew initializeWithName: aName
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
