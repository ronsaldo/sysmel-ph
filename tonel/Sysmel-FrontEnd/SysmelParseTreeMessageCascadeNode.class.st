Class {
	#name : 'SysmelParseTreeMessageCascadeNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'receiver',
		'messages'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeMessageCascadeNode >> accept: visitor [
	^ visitor visitMessageCascadeNode: self
]

{ #category : 'testing' }
SysmelParseTreeMessageCascadeNode >> isMessageCascadeNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeNode >> messages [

	^ messages
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeNode >> messages: anObject [

	messages := anObject
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeNode >> receiver [

	^ receiver
]

{ #category : 'accessing' }
SysmelParseTreeMessageCascadeNode >> receiver: anObject [

	receiver := anObject
]
