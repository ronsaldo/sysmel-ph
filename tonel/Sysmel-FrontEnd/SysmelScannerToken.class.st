"
I am a single token produced by the Sysmel scanner.
"
Class {
	#name : 'SysmelScannerToken',
	#superclass : 'Object',
	#instVars : [
		'kind',
		'sourcePosition',
		'errorMessage'
	],
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd',
	#package : 'Sysmel-FrontEnd'
}

{ #category : 'accessing' }
SysmelScannerToken >> errorMessage [

	^ errorMessage
]

{ #category : 'accessing' }
SysmelScannerToken >> errorMessage: anObject [

	errorMessage := anObject
]

{ #category : 'accessing' }
SysmelScannerToken >> kind [

	^ kind
]

{ #category : 'accessing' }
SysmelScannerToken >> kind: anObject [

	kind := anObject
]

{ #category : 'accessing' }
SysmelScannerToken >> sourcePosition [

	^ sourcePosition
]

{ #category : 'accessing' }
SysmelScannerToken >> sourcePosition: anObject [

	sourcePosition := anObject
]
