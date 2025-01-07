Class {
	#name : 'SysmelTypedStoreNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'pointer',
		'value'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedStoreNode >> accept: visitor [
	^ visitor visitStoreNode: self
]

{ #category : 'accessing' }
SysmelTypedStoreNode >> pointer [

	^ pointer
]

{ #category : 'accessing' }
SysmelTypedStoreNode >> pointer: anObject [

	pointer := anObject
]

{ #category : 'accessing' }
SysmelTypedStoreNode >> value [

	^ value
]

{ #category : 'accessing' }
SysmelTypedStoreNode >> value: anObject [

	value := anObject
]
