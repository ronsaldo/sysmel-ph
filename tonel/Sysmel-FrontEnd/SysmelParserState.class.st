"
I hold a specific parser state.
"
Class {
	#name : 'SysmelParserState',
	#superclass : 'Object',
	#instVars : [
		'sourceCode',
		'tokens',
		'position'
	],
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'stream in' }
SysmelParserState >> advance [
	self advance: 1
]

{ #category : 'stream in' }
SysmelParserState >> advance: offset [
	position := position + offset
]

{ #category : 'as yet unclassified' }
SysmelParserState >> advanceWithExpectedError: errorMessage [
	| errorPosition |
	self peekKind = SSTError ifTrue: [
		| errorToken |
		errorToken := self next.
		^ SysmelParseTreeErrorNode new
			sourcePosition: errorToken currentSourcePosition;
			errorMessage: errorToken errorMessage;
			yourself
	].
	self atEnd ifTrue: [
		^ SysmelParseTreeErrorNode new
			sourcePosition: self currentSourcePosition;
			errorMessage: errorMessage;
			yourself
	].
	errorPosition := self currentSourcePosition.
	self advance.
	^ SysmelParseTreeErrorNode new
			sourcePosition: errorPosition;
			errorMessage: errorMessage;
			yourself
]

{ #category : 'accessing' }
SysmelParserState >> atEnd [
	^ position > tokens size
]

{ #category : 'as yet unclassified' }
SysmelParserState >> currentSourcePosition [
	position <= tokens size ifTrue: [
		^ (tokens at: position) sourcePosition
	].

	self assert: tokens last kind = SSTEndOfSource.
	^ tokens last sourcePosition
]

{ #category : 'as yet unclassified' }
SysmelParserState >> expect: expectedKind addingErrorToNode: expression [
	self peekKind = expectedKind ifTrue: [
		self advance.
		^ expression 
	].
	self halt.
	^ SysmelParseTreeErrorNode new
		errorMessage: 'Expected a specific token';
		innerNodes: { expression };
		yourself
]

{ #category : 'initialization' }
SysmelParserState >> initialize [
	position := 1
]

{ #category : 'as yet unclassified' }
SysmelParserState >> memento [
	^ position
]

{ #category : 'stream in' }
SysmelParserState >> next [
	| result |
	result := self peek.
	self atEnd ifFalse: [ self advance ].
	^ result
]

{ #category : 'stream in' }
SysmelParserState >> peek [
	^ self peek: 0
]

{ #category : 'stream in' }
SysmelParserState >> peek: offset [
	position + offset > tokens size ifTrue: [ ^ nil ].
	^ tokens at: position + offset
	
]

{ #category : 'stream in' }
SysmelParserState >> peekKind [
	^ self peekKind: 0
]

{ #category : 'stream in' }
SysmelParserState >> peekKind: offset [
	^ (self peek: offset) ifNotNil: [ :token | token kind ] ifNil: [ -1 ] 
]

{ #category : 'accessing' }
SysmelParserState >> position [

	^ position
]

{ #category : 'accessing' }
SysmelParserState >> position: anObject [

	position := anObject
]

{ #category : 'as yet unclassified' }
SysmelParserState >> previousSourcePosition [
	self assert: position > 1.
	^ (tokens at: position - 1) sourcePosition
]

{ #category : 'as yet unclassified' }
SysmelParserState >> restore: aMemento [
	position := aMemento
]

{ #category : 'accessing' }
SysmelParserState >> sourceCode [

	^ sourceCode
]

{ #category : 'accessing' }
SysmelParserState >> sourceCode: anObject [

	sourceCode := anObject
]

{ #category : 'as yet unclassified' }
SysmelParserState >> sourcePositionFrom: startPosition [
	| startPositionFromToken endSourcePosition |
	self assert: startPosition <= tokens size.
	startPositionFromToken := (tokens at: startPosition) sourcePosition.
	position > 1 ifTrue: [
		endSourcePosition := self previousSourcePosition.
		^ startPositionFromToken to: endSourcePosition
	] ifFalse: [ 
		endSourcePosition := self currentSourcePosition.
		^ startPositionFromToken until: endSourcePosition
	].

]

{ #category : 'accessing' }
SysmelParserState >> tokens [

	^ tokens
]

{ #category : 'accessing' }
SysmelParserState >> tokens: anObject [

	tokens := anObject
]
