"
I am a Sysmel parser.
"
Class {
	#name : 'SysmelParser',
	#superclass : 'Object',
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'parsing' }
SysmelParser >> parseExpressionListUntilEndOrDelimiter: delimiter state: state [
	| elements |
	elements := OrderedCollection new.
	
	"Chop the initial dots"
	[ state peekKind = SSTDot ] whileTrue: [
		state advance
	].

	^ elements
]

{ #category : 'parsing' }
SysmelParser >> parseSequenceUntilEndOrDelimiter: delimiter state: state [
	| initialPosition elements |
	initialPosition := state position.
	elements := self parseExpressionListUntilEndOrDelimiter: delimiter state: state.
	elements size = 1 ifTrue: [ ^ elements first ].
	
	^ SysmelParseTreeSequenceNode new
		sourcePosition: (state sourcePositionFrom: initialPosition);
		elements: elements;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseSourceCode: aSourceCode [
	| tokens |
	tokens := (SysmelScanner new scanSourceCode: aSourceCode) asArray.
	^ self parseSourceCode: aSourceCode tokens: tokens
]

{ #category : 'parsing' }
SysmelParser >> parseSourceCode: aSourceCode tokens: tokens [
	| state |
	state := SysmelParserState new
		sourceCode: aSourceCode;
		tokens: tokens;
		yourself.
	^ self parseWithState: state
]

{ #category : 'parsing' }
SysmelParser >> parseTopLevelExpression: state [
	^ self parseSequenceUntilEndOrDelimiter: SSTEndOfSource state: state
]

{ #category : 'parsing' }
SysmelParser >> parseWithState: state [
	^ self parseTopLevelExpression: state
]
