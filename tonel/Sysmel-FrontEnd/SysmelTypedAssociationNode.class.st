Class {
	#name : 'SysmelTypedAssociationNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'key',
		'value'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedAssociationNode >> accept: visitor [
	^ visitor visitAssociationNode: self
]

{ #category : 'accessing' }
SysmelTypedAssociationNode >> key [

	^ key
]

{ #category : 'accessing' }
SysmelTypedAssociationNode >> key: anObject [

	key := anObject
]

{ #category : 'accessing' }
SysmelTypedAssociationNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelTypedAssociationNode >> value: anObject [

	value := anObject
]
