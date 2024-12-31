"
I am a tokenizer used for parsing sysmel code.
"
Class {
	#name : 'SysmelScanner',
	#superclass : 'Object',
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd',
	#package : 'Sysmel-FrontEnd'
}

{ #category : 'scanning' }
SysmelScanner >> scanNextTokenWithState: state [
	| whiteErrorToken |
	whiteErrorToken := self skipWhite: state.
	whiteErrorToken ifNotNil: [ ^ whiteErrorToken ].
	
	state atEnd ifTrue: [ ^ state makeToken: SSTEndOfSource ].
	self halt
]

{ #category : 'scanning' }
SysmelScanner >> scanSourceCode: sourceCode [
	| state tokens token |
	state := SysmelScannerState new initializeWithSourceCode: sourceCode.
	tokens := OrderedCollection new.
	[  
		token := self scanNextTokenWithState: state.
		tokens add: token.
	] doWhileTrue: [ token kind ~~ SSTEndOfSource ].
	
	^ tokens
]

{ #category : 'as yet unclassified' }
SysmelScanner >> skipWhite: state [
	| hasSeenComments |
	hasSeenComments := true.
	[
		hasSeenComments := false.
		"Chop the leading whites"
		[ state atEnd not and: [state peek <= Character space] ] whileTrue: [ state advance ].
	
	] doWhileTrue: [ hasSeenComments ].
	^ nil
]
