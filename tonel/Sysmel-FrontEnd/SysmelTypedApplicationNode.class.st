Class {
	#name : 'SysmelTypedApplicationNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'functional',
		'arguments'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedApplicationNode >> accept: visitor [
	^ visitor visitApplicationNode: self
]

{ #category : 'accessing' }
SysmelTypedApplicationNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelTypedApplicationNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SysmelTypedApplicationNode >> functional [

	^ functional
]

{ #category : 'accessing' }
SysmelTypedApplicationNode >> functional: anObject [

	functional := anObject
]
