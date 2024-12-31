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

{ #category : 'testing' }
SysmelScanner >> isDigit: character [
	^ $0 <= character and: [ character <= $9 ]
]

{ #category : 'testing' }
SysmelScanner >> isE: character [
	^ 'eE' includes: character
]

{ #category : 'testing' }
SysmelScanner >> isIdentifierMiddle: c [
	^ (self isIdentifierStart: c) or: [ self isDigit: c ]
]

{ #category : 'testing' }
SysmelScanner >> isIdentifierStart: c [
	^ ($A <= c and: [c <= $Z]) or:
		[ ($a <= c and: [c <= $z])
			or: [ c = $_ ] ]
]

{ #category : 'testing' }
SysmelScanner >> isOperatorCharacter: c [
	^ '+-/\\*~<>=@%|&?!' includes: c
]

{ #category : 'as yet unclassified' }
SysmelScanner >> scanAdvanceKeyword: state [
	| initialState |
	state atEnd ifTrue: [ ^ false ].
	(self isIdentifierStart: (state peek)) ifFalse: [ ^ false ].
	initialState := state memento.
	[ self isIdentifierMiddle: state peek ] whileTrue: [ 
		state advance
	].

	state peek ~= $: ifTrue: [
		state restore: initialState.
		^ false
	].

	state advance.
	^ true
]

{ #category : 'scanning' }
SysmelScanner >> scanNextTokenWithState: state [
	| whiteErrorToken initialState c |
	whiteErrorToken := self skipWhite: state.
	whiteErrorToken ifNotNil: [ ^ whiteErrorToken ].
	
	state atEnd ifTrue: [ ^ state makeToken: SSTEndOfSource ].
	
	initialState := state copy.
	c := state peek.
	
	(self isIdentifierStart: c) ifTrue: [
		state advance.
		[ state atEnd not and: [ self isIdentifierMiddle: (state peek)] ] whileTrue: [ state advance ].
	
		state peek = $: ifTrue: [
			| isMultiKeyword hasAdvanced |
			state advance.
			isMultiKeyword := false.
			hasAdvanced := true.
			[ hasAdvanced ] whileTrue: [
				hasAdvanced  := self scanAdvanceKeyword: state.
				isMultiKeyword := isMultiKeyword or: [ hasAdvanced ].
			].
			^ state makeToken: (isMultiKeyword
				ifTrue: [ SSTMultiKeyword ]
				ifFalse: [SSTKeyword]) startingFrom: initialState.
		].
	
		^ state makeToken: SSTIdentifier startingFrom: initialState.
	]
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
		"Chop the leading whites"
		hasSeenComments := false.
		[ state atEnd not and: [state peek <= Character space] ] whileTrue: [ state advance ].
		
		(state peek = $#) ifTrue: [
			(state peek: 1) = $# ifTrue: [
				state advance: 2.
				[ state atEnd not and: [ state peekNewLine not ]] whileTrue: [ state advance ].
				hasSeenComments := true
			] ifFalse: [
				"Multiline comment"
				(state peek: 1) = $* ifTrue: [
					| commentInitialState hasCommentEnd|
					commentInitialState := state copy.
					hasSeenComments := true.
					state advance: 2.
					hasCommentEnd := false.
					[ state atEnd not and: [ hasCommentEnd not ] ] whileTrue: [
						hasCommentEnd := state peek = $* and: [(state peek: 1) = $#].
						hasCommentEnd
							ifTrue: [ state advance: 2  ]
							ifFalse: [ state advance  ] 
					].
				
					hasCommentEnd ifFalse: [ ^ state makeErrorTokenStartingFrom: commentInitialState withMessage: 'Incomplete multiline comment']
				]
			]
		]
	
	] doWhileTrue: [ hasSeenComments ].
	^ nil
]
