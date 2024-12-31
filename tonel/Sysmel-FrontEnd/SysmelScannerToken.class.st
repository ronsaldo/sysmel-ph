"
I am a single token produced by the Sysmel scanner.
"
Class {
	#name : 'SysmelScannerToken',
	#superclass : 'Object',
	#instVars : [
		'kind',
		'sourcePosition'
	],
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd',
	#package : 'Sysmel-FrontEnd'
}

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
