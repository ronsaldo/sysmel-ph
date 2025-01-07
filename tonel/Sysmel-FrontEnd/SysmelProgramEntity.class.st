Class {
	#name : 'SysmelProgramEntity',
	#superclass : 'Object',
	#instVars : [
		'users',
		'userSet'
	],
	#category : 'Sysmel-FrontEnd-Environment',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Environment'
}

{ #category : 'as yet unclassified' }
SysmelProgramEntity >> addUser: anUserInstruction [
	(userSet includes: anUserInstruction) ifFalse: [ 
		users add: anUserInstruction.
		userSet add: anUserInstruction
	]
]

{ #category : 'as yet unclassified' }
SysmelProgramEntity >> allUsers [
	^ users
]

{ #category : 'enumerating' }
SysmelProgramEntity >> dataDependenciesDo: aBlock [
	"I am not an instruction, so do nothing."
]

{ #category : 'initialization' }
SysmelProgramEntity >> initialize [
	super initialize.
	users := OrderedCollection new.
	userSet := IdentitySet new.
]

{ #category : 'testing' }
SysmelProgramEntity >> isGlobalProgramEntity [
	^ true
]

{ #category : 'testing' }
SysmelProgramEntity >> isPinnedInstruction [
	^ false
]
