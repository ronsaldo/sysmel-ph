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

{ #category : 'testing' }
SysmelParser >> isBinaryExpressionOperator: kind [
	^ {SSTOperator . SSTStar . SSTLessThan . SSTGreaterThan . SSTBar} includes: kind 
]

{ #category : 'parsing' }
SysmelParser >> parseCEscapeSequences: string [
	^ ByteString streamContents: [ :out |
		| i size |
		i := 1.
		size := string size.
		[ i <= size ] whileTrue: [
			| c |
			c := string at: i.
			c = $\ ifTrue: [
				i + 1 <= size ifTrue: [
					i := i + 1.
					c := string at: i.
					('rnt' includes: c) ifTrue: [
						| escapedCharacter |
						escapedCharacter := nil.
						c = $r ifTrue: [ escapedCharacter := Character cr ].
						c = $n ifTrue: [ escapedCharacter := Character lf ].
						c = $t ifTrue: [ escapedCharacter := Character tab ].
						escapedCharacter ifNil: [self error: 'Should not reach this'].
						out nextPut: escapedCharacter.
						i := i + 1
					] ifFalse: [
						out nextPut: c.
						i := i + 1
					]
				]
			] ifFalse: [
				out nextPut: c.
				i := i + 1
			]
		]
	]
]

{ #category : 'parsing' }
SysmelParser >> parseExpression: state [
	^ self parseTerm: state
]

{ #category : 'parsing' }
SysmelParser >> parseExpressionListUntilEndOrDelimiter: delimiter state: state [
	| elements expectsExpresion |
	elements := OrderedCollection new.
	
	"Chop the initial dots"
	[ state peekKind = SSTDot ] whileTrue: [
		state advance
	].
	
	expectsExpresion := true.
	[ state atEnd not and: [ state peekKind ~= delimiter ] ] whileTrue: [
		| expression |
		expectsExpresion ifFalse: [
			elements add: (SysmelParseTreeErrorNode new
				sourcePosition: state currentSourcePosition;
				errorMessage: 'Expected a dot before expression.';
				yourself)
		].
		
		expression := self parseExpression: state.
		elements add: expression.
		
		expectsExpresion := false.
		[ state peekKind = SSTDot ] whileTrue: [
			state advance.
			expectsExpresion := true
		].
	
	].
	^ elements
]

{ #category : 'parsing' }
SysmelParser >> parseIdentifierReference: state [
	| token |
	token := state next.
	self assert: token kind = SSTIdentifier.
	^ SysmelParseTreeIdentifierReferenceNode new
		sourcePosition: token sourcePosition;
		name: token getTextValue asSymbol;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseLiteral: state [
	state peekKind = SSTNat ifTrue: [ ^ self parseLiteralInteger: state ].
	state peekKind = SSTFloat ifTrue: [ ^ self parseLiteralFloat: state ].
	state peekKind = SSTString ifTrue: [ ^ self parseLiteralString: state ].
	state peekKind = SSTCharacter ifTrue: [ ^ self parseLiteralCharacter: state ].
	state peekKind = SSTSymbol ifTrue: [ ^ self parseLiteralSymbol: state ].
	^ state advanceWithExpectedError: 'Expected a literal'
]

{ #category : 'parsing' }
SysmelParser >> parseLiteralCharacter: state [
	| token value tokenValue |
	token := state next.
	self assert: token kind = SSTCharacter .
	tokenValue := token getTextValue.
	value := tokenValue second .
	^ SysmelParseTreeLiteralCharacterNode new
		sourcePosition: token sourcePosition;
		value: value;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseLiteralFloat: state [
	| token value |
	token := state next.
	self assert: token kind = SSTFloat.
	value := Float readFrom: token getTextValue readStream.
	^ SysmelParseTreeLiteralFloatNode new
		sourcePosition: token sourcePosition;
		value: value;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseLiteralInteger: state [
	| token value textValue radix digit |
	token := state next.
	self assert: token kind = SSTNat.
	textValue := token getTextValue.
	value := 0.
	radix := 10.
	textValue do: [ :each |
		('rR' includes: each) ifTrue: [
			radix := value.
			value := 0
		] ifFalse: [
			digit := 0.
			($0 <= each and: [ each <= $9 ]) ifTrue: [ 
				digit := (each asInteger - $0 asInteger)
			].
			($a <= each and: [ each <= $z ]) ifTrue: [ 
				digit := (each asInteger - $a asInteger) + 10
			].
			($A <= each and: [ each <= $Z ]) ifTrue: [ 
				digit := (each asInteger - $A asInteger) + 10
			].
			value := value*radix + digit
		]
	].
	
	^ SysmelParseTreeLiteralIntegerNode new
		sourcePosition: token sourcePosition;
		value: value;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseLiteralString: state [
	| token value cstring |
	token := state next.
	self assert: token kind = SSTString.
	cstring := token getTextValue.
	cstring := cstring copyFrom: 2 to: cstring size - 1.
	value := self parseCEscapeSequences: cstring.
	^ SysmelParseTreeLiteralStringNode new
		sourcePosition: token sourcePosition;
		value: value;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseLiteralSymbol: state [
	| token value textValue stringContent |
	token := state next.
	self assert: token kind = SSTSymbol.
	textValue := token getTextValue.
	((textValue beginsWith: '#"') and: [ textValue endsWith: '"' ]) ifTrue: [
		stringContent := textValue copyFrom: 3 to: textValue size - 1.
		stringContent := self parseCEscapeSequences: stringContent.
		value := stringContent asSymbol
	] ifFalse: [
		(textValue beginsWith: '#') ifTrue: [
			value := textValue allButFirst asSymbol.
		].
	].

	^ SysmelParseTreeLiteralSymbolNode new
		sourcePosition: token sourcePosition;
		value: value;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseParenthesis: state [
	"("
	| startPosition token expression |
	startPosition := state position.
	self assert: state peekKind = SSTLeftParent.
	state advance.
	
	((self isBinaryExpressionOperator: state peekKind) and: [ (state peekKind: 1) = SSTRightParent]) ifTrue: [ 
		token := state next.
		state advance.
		^ SysmelParseTreeIdentifierReferenceNode new
			sourcePosition: token sourcePosition;
			name: token getText asSymbol;
			yourself
	].

	state peekKind = SSTRightParent ifTrue: [ 
		state advance.
		^ SysmelParseTreeTupleNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			elements: #();
			yourself
	].
	
	expression := self parseSequenceUntilEndOrDelimiter: SSTRightParent state: state.
	
	")"
	expression := state expect: SSTRightParent addingErrorToNode: expression.
	^ expression
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
SysmelParser >> parseTerm: state [
	state peekKind = SSTIdentifier ifTrue: [ ^ self parseIdentifierReference: state ].
	state peekKind = SSTLeftParent ifTrue: [ ^ self parseParenthesis: state ].
	state peekKind = SSTLeftCurlyBracket ifTrue: [ ^ self parseBlock: state ].
	state peekKind = SSTDictionaryStart ifTrue: [ ^ self parseDictionary: state ].
	state peekKind = SSTColon ifTrue: [ ^ self parseBindableName: state ].
	
	^ self parseLiteral: state
]

{ #category : 'parsing' }
SysmelParser >> parseTopLevelExpression: state [
	^ self parseSequenceUntilEndOrDelimiter: SSTEndOfSource state: state
]

{ #category : 'parsing' }
SysmelParser >> parseWithState: state [
	^ self parseTopLevelExpression: state
]
