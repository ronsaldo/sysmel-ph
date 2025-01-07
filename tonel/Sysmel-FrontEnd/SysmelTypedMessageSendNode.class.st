Class {
	#name : 'SysmelTypedMessageSendNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'receiver',
		'selector',
		'arguments'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedMessageSendNode >> accept: visitor [
	^ visitor visitMessageSendNode: self
]

{ #category : 'accessing' }
SysmelTypedMessageSendNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelTypedMessageSendNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SysmelTypedMessageSendNode >> receiver [

	^ receiver
]

{ #category : 'accessing' }
SysmelTypedMessageSendNode >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
SysmelTypedMessageSendNode >> selector [

	^ selector
]

{ #category : 'accessing' }
SysmelTypedMessageSendNode >> selector: anObject [

	selector := anObject
]
