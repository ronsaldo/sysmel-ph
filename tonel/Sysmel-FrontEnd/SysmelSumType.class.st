Class {
	#name : 'SysmelSumType',
	#superclass : 'SysmelType',
	#instVars : [
		'alternatives'
	],
	#category : 'Sysmel-FrontEnd-TypeSystem',
	#package : 'Sysmel-FrontEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelSumType >> alternatives [

	^ alternatives
]

{ #category : 'accessing' }
SysmelSumType >> alternatives: anObject [

	alternatives := anObject
]
