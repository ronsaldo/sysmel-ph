"
I am a tokenizer used for parsing sysmel code.
"
Class {
	#name : 'SysmelScanner',
	#superclass : 'Object',
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd-Scanner',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Scanner'
}

{ #category : 'testing' }
SysmelScanner >> isDigit: character [
	character isInteger ifTrue: [ ^ false ].
	^ $0 <= character and: [ character <= $9 ]
]

{ #category : 'testing' }
SysmelScanner >> isE: character [
	character isInteger ifTrue: [ ^ false ].
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

{ #category : 'testing' }
SysmelScanner >> isPlusOrMinus: character [
	character isInteger ifTrue: [ ^ false ].
	^ '+-' includes: character
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
	].
	
	(self isDigit: c) ifTrue: [
		state advance.
		[state atEnd not and: [ self isDigit: state peek ]] whileTrue: [
			state advance
		].
			
		"Parse the radix"
		(state atEnd not and: [ 'rR' includes: state peek ]) ifTrue: [
			state advance.
			[state atEnd not and: [ self isIdentifierMiddle: state peek ]] whileTrue: [
				state advance
			].
			
			^ state makeToken: SSTNat startingFrom: initialState
		].
	
		"Decimal point"
		(state peek = $. and: [ self isDigit: (state peek:1) ]) ifTrue: [
			state advance: 2.
			[state atEnd not and: [ self isDigit: state peek ]] whileTrue: [
				state advance
			].
		
			"Decimal exponent"
			((self isE: state peek) and: [ (self isDigit: (state peek: 1)) 
				or: [(self isPlusOrMinus: (state peek: 1)) and: (self isDigit: (state peek: 2))]]) ifTrue: [
				state advance: 2.
				[state atEnd not and: [ self isDigit: state peek ]] whileTrue: [
					state advance
				]
			].
	
			^ state makeToken: SSTFloat startingFrom: initialState
		].
		
		^ state makeToken: SSTNat startingFrom: initialState
	].

	"Symbols"
	c = $# ifTrue: [
		| c1 |
		c1 := state peek: 1.
		c1 isInteger ifTrue: [
			state advance.
			state makeErrorTokenStartingFrom: initialState withMessage: 'Unsupported single #'
		].
	
		(self isIdentifierStart: c1) ifTrue: [
			state advance: 2.
			[ state atEnd not and: [self isIdentifierMiddle: state peek] ] whileTrue: [
				state advance
			].
			
			state peek = $: ifTrue: [
				| isMultiKeyword hasAdvanced |
				state advance.
				isMultiKeyword := false.
				hasAdvanced := true.
				[ hasAdvanced ] whileTrue: [
					hasAdvanced  := self scanAdvanceKeyword: state.
					isMultiKeyword := isMultiKeyword or: [ hasAdvanced ].
				].
				^ state makeToken: SSTSymbol startingFrom: initialState.
			].
		
			^ state makeToken: SSTSymbol startingFrom: initialState
		].
	
		(self isOperatorCharacter: c1) ifTrue: [
			state advance: 2.
			[ state atEnd not and: [ self isOperatorCharacter: state peek ] ] whileTrue: [
				state advance
			].
		
			^ state makeToken: SSTSymbol startingFrom: initialState
		].
	
		c1 = $" ifTrue: [
			state advance: 2.
			[state atEnd not and: [state peek ~= $"]] whileTrue: [
				(state peek == $\ and: [(state peek: 1) isCharacter ]) ifTrue: [ 
					state advance: 2
				] ifFalse: [
					state advance
				]
			].
			state peek ~= $" ifTrue: [
				^ state makeErrorTokenStartingFrom: initialState withMessage: 'Incomplete string symbolliteral.'
			].
			state advance.
			^ state makeToken: SSTSymbol startingFrom: initialState
		].
	
		c1 = $[ ifTrue: [ 
			state advance: 2.
			^ state makeToken: SSTByteArrayStart startingFrom: initialState
		].
		c1 = ${ ifTrue: [ 
			state advance: 2.
			^ state makeToken: SSTDictionaryStart startingFrom: initialState
		].
		c1 = $( ifTrue: [ 
			state advance: 2.
			^ state makeToken: SSTLiteralArrayStart startingFrom: initialState
		]
	].

	"Strings"
	c = $" ifTrue: [
		state advance.
		[state atEnd not and: [state peek ~= $"]] whileTrue: [
			(state peek == $\ and: [(state peek: 1) isCharacter ]) ifTrue: [ 
				state advance: 2
			] ifFalse: [
				state advance
			]
		].
		state peek ~= $" ifTrue: [
			^ state makeErrorTokenStartingFrom: initialState withMessage: 'Incomplete string literal.'
		].
		state advance.
		
		^ state makeToken: SSTString startingFrom: initialState
	].

	"Characters"
	c = $' ifTrue: [
		state advance.
		[state atEnd not and: [state peek ~= $']] whileTrue: [
			(state peek == $\ and: [(state peek: 1) isCharacter ]) ifTrue: [ 
				state advance: 2
			] ifFalse: [
				state advance
			]
		].
		state peek ~= $' ifTrue: [
			^ state makeErrorTokenStartingFrom: initialState withMessage: 'Incomplete character literal.'
		].
		state advance.
		
		^ state makeToken: SSTString startingFrom: initialState
	].
	"Punctuation"
	c = $( ifTrue: [ state advance. ^ state makeToken: SSTLeftParent startingFrom: initialState ].
	c = $) ifTrue: [ state advance. ^ state makeToken: SSTRightParent startingFrom: initialState ].
	c = $[ ifTrue: [ state advance. ^ state makeToken: SSTLeftBracket startingFrom: initialState ].
	c = $] ifTrue: [ state advance. ^ state makeToken: SSTRightBracket startingFrom: initialState ].
	c = ${ ifTrue: [ state advance. ^ state makeToken: SSTLeftCurlyBracket startingFrom: initialState ].
	c = $} ifTrue: [ state advance. ^ state makeToken: SSTRightCurlyBracket startingFrom: initialState ].
	c = $; ifTrue: [ state advance. ^ state makeToken: SSTSemicolon startingFrom: initialState ].
	c = $, ifTrue: [ state advance. ^ state makeToken: SSTComma startingFrom: initialState ].
	c = $. ifTrue: [
		state advance. 
		(state peek = $. and: [ (state peek: 1) = $. ]) ifTrue: [ 
			state advance: 2.
			^ state makeToken: SSTEllipsis startingFrom: initialState ].
		^ state makeToken: SSTDot startingFrom: initialState
		].
	c = $: ifTrue: [
		state advance.
		state peek = $: ifTrue: [
			state advance.
			^ state makeToken: SSTColonColon startingFrom: initialState ].
		state peek = $= ifTrue: [
			state advance.
			^ state makeToken: SSTAssignment startingFrom: initialState ].
		^ state makeToken: SSTColon startingFrom: initialState 
		].
	
	c = $` ifTrue: [
		| c2 |
		c2 := state peek.
		c2 = $' ifTrue: [ ^ state makeToken: SSTQuote startingFrom: initialState ].
		c2 = $` ifTrue: [ ^ state makeToken: SSTQuasiQuote startingFrom: initialState ].
		c2 = $, ifTrue: [ ^ state makeToken: SSTQuasiUnquote startingFrom: initialState ].
		c2 = $@ ifTrue: [ ^ state makeToken: SSTSplice startingFrom: initialState ].
	].

	c = $| ifTrue: [
		(self isOperatorCharacter: (state peek:1)) ifFalse: [ 
			state advance.
			^ state makeToken: SSTBar startingFrom: initialState 
		]
	].

	"Operators"
	(self isOperatorCharacter: c) ifTrue: [
		| operatorToken |
		[state atEnd not and: [ self isOperatorCharacter: state peek ]] whileTrue: [
			state advance
		].
	
		operatorToken := state makeToken: SSTOperator startingFrom: initialState.
		^ self selectMoreSpecificKindForOperatorToken: operatorToken
	].
	
	"Unexpected characters"

	state atEnd ifFalse: [ 
		state advance.
	].
	^ state makeErrorTokenStartingFrom: initialState withMessage: ('Unexpected character {1}.' format: {c})
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

{ #category : 'scanning' }
SysmelScanner >> selectMoreSpecificKindForOperatorToken: operatorToken [
	| textValue |
	textValue := operatorToken getTextValue.
	textValue = '<' ifTrue: [ operatorToken kind: SSTLessThan ].
	textValue = '>' ifTrue: [ operatorToken kind: SSTGreaterThan ].
	textValue = '*' ifTrue: [ operatorToken kind: SSTStar ].
	textValue = '?' ifTrue: [ operatorToken kind: SSTQuestion ].
	textValue = '!' ifTrue: [ operatorToken kind: SSTBang ].
	textValue = '<-' ifTrue: [ operatorToken kind: SSTBindOperator ].
	
	^ operatorToken
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
