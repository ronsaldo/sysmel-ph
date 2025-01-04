Class {
	#name : 'SysmelParseTreeMessageSendNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'receiver',
		'selector',
		'arguments'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'testing' }
SysmelParseTreeMessageSendNode >> accept: visitor [
	^ visitor visitMessageSendNode: self
]

{ #category : 'accessing' }
SysmelParseTreeMessageSendNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelParseTreeMessageSendNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'converting' }
SysmelParseTreeMessageSendNode >> asChainOfUnaryIdentifiers [
	| receiverChain |
	arguments isNotEmpty ifTrue: [
		self error: 'Invalid message send for getting a chain of unary identifiers.'
	].
	^ receiver asChainOfUnaryIdentifiers , selector asChainOfUnaryIdentifiers.
]

{ #category : 'converting' }
SysmelParseTreeMessageSendNode >> asMessageSendCascadeReceiverAndFirstMessage [
	| cascaded |
	cascaded := SysmelParseTreeMessageCascadeMessageNode new
		sourcePosition: sourcePosition;
		selector: selector;
		arguments: arguments.
	^ { receiver . cascaded }
]

{ #category : 'testing' }
SysmelParseTreeMessageSendNode >> isMessageSendNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeMessageSendNode >> receiver [

	^ receiver
]

{ #category : 'accessing' }
SysmelParseTreeMessageSendNode >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
SysmelParseTreeMessageSendNode >> selector [

	^ selector
]

{ #category : 'accessing' }
SysmelParseTreeMessageSendNode >> selector: anObject [

	selector := anObject
]
