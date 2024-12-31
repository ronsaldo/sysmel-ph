"
I represent a specific state of the scanner.
"
Class {
	#name : 'SysmelScannerState',
	#superclass : 'Object',
	#instVars : [
		'sourceCode',
		'position',
		'line',
		'column',
		'isPreviousCR'
	],
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd',
	#package : 'Sysmel-FrontEnd'
}

{ #category : 'accessing' }
SysmelScannerState >> atEnd [
	^ position > sourceCode text size
]

{ #category : 'initialization' }
SysmelScannerState >> initializeWithSourceCode: aSourceCode [
	sourceCode := aSourceCode.
	position := 1.
	line := 1.
	column := 1.
	isPreviousCR := false.
	
]

{ #category : 'accessing' }
SysmelScannerState >> makeToken: tokenKind [
	^ SysmelScannerToken new
		kind: tokenKind;
		sourcePosition: (SysmelSourcePosition new
			sourceCode: sourceCode;
			startIndex: position;
			endIndex: position;
			startLine: line;
			endLine: line;
			startColumn: column;
			endColumn: column);
		yourself
]

{ #category : 'stream in' }
SysmelScannerState >> peek [
	^ self peek: 0
]

{ #category : 'stream in' }
SysmelScannerState >> peek: offset [
	position + offset > sourceCode text size ifTrue: [ ^ -1 ].
	^ sourceCode text at: position + offset
]
