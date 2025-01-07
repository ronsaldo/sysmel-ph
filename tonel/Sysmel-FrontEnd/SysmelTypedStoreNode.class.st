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
