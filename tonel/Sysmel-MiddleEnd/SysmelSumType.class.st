Class {
	#name : 'SysmelSumType',
	#superclass : 'SysmelType',
	#instVars : [
		'alternatives'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
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
