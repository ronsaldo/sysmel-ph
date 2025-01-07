Class {
	#name : 'SysmelTypedSequenceNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'expressions'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedSequenceNode >> accept: visitor [
	^ visitor visitSequenceNode: self
]

{ #category : 'accessing' }
SysmelTypedSequenceNode >> expressions [

	^ expressions
]

{ #category : 'accessing' }
SysmelTypedSequenceNode >> expressions: anObject [

	expressions := anObject
]

{ #category : 'as yet unclassified' }
SysmelTypedSequenceNode >> findAllExportableObjects [
	| foundObjects |
	foundObjects := OrderedCollection new.
	expressions do: [ :each |
		foundObjects addAll: each findAllExportableObjects
	].
	^ foundObjects
]
