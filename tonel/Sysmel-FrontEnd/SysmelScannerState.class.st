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
	#category : 'Sysmel-FrontEnd-Scanner',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Scanner'
}

{ #category : 'accessing' }
SysmelScannerState >> advance [
	| c |
	self assert: position <= sourceCode text size.
	c := sourceCode text at: position.
	position := position + 1.
	c = Character cr ifTrue: [
		line := line + 1.
		column := 1.
		isPreviousCR := true.
		^ self
	].
	c = Character lf ifTrue: [
		isPreviousCR ifFalse: [
			line := line + 1.
			column := 1
		].
		isPreviousCR := false.
		^ self
	].
	c = Character tab ifTrue: [
		column := (column + 4) %4 * 4 + 1.
		^ self
	].

	column := column + 1
]

{ #category : 'accessing' }
SysmelScannerState >> advance: count [
	1 to: count do: [:i | self advance ].
]

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

{ #category : 'as yet unclassified' }
SysmelScannerState >> makeErrorTokenStartingFrom: startingState withMessage: errorMessage [
	| startSourcePosition endSourcePosition sourcePosition |
	startSourcePosition := startingState sourcePosition.
	endSourcePosition := self sourcePosition.
	sourcePosition := startSourcePosition to: endSourcePosition.
	^ SysmelScannerToken new
		sourcePosition: sourcePosition;
		kind: SSTError;
		errorMessage: errorMessage;
		yourself
]

{ #category : 'accessing' }
SysmelScannerState >> makeToken: tokenKind [
	^ SysmelScannerToken new
		kind: tokenKind;
		sourcePosition: self sourcePosition;
		yourself
]

{ #category : 'as yet unclassified' }
SysmelScannerState >> makeToken: tokenKind startingFrom: startingState [
	| startSourcePosition endSourcePosition sourcePosition |
	startSourcePosition := startingState sourcePosition.
	endSourcePosition := self sourcePosition.
	sourcePosition := startSourcePosition to: endSourcePosition.
	^ SysmelScannerToken new
		sourcePosition: sourcePosition;
		kind: tokenKind;
		yourself
]

{ #category : 'as yet unclassified' }
SysmelScannerState >> memento [
	^ {sourceCode . position . line . column . isPreviousCR}
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

{ #category : 'stream in' }
SysmelScannerState >> peekNewLine [
	| c |
	c := self peek.
	^ c = Character cr or: [ c = Character lf ]
]

{ #category : 'as yet unclassified' }
SysmelScannerState >> restore: memento [
	sourceCode := memento first.
	position := memento second.
	line := memento third.
	column := memento fourth.
	isPreviousCR := memento fifth.
]

{ #category : 'accessing' }
SysmelScannerState >> sourceCode [
	^ sourceCode
]

{ #category : 'accessing' }
SysmelScannerState >> sourcePosition [
	^ SysmelSourcePosition new
			sourceCode: sourceCode;
			startIndex: position;
			endIndex: position;
			startLine: line;
			endLine: line;
			startColumn: column;
			endColumn: column;
			yourself
]
