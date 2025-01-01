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
SysmelParser >> parseAssignmentExpression: state [
	| startPosition assignedStore assignedValue |
	startPosition := state position.
	assignedStore := self parseLowPrecedenceExpression: state.
	state peekKind = SSTAssignment ifTrue: [
		state advance.
		assignedValue := self parseAssignmentExpression: state.
		^ SysmelParseTreeAssignmentNode new
				sourcePosition: (state sourcePositionFrom: startPosition);
				store: assignedStore;
				value: assignedValue;
				yourself.
	] ifFalse: [
		^ assignedStore
	]
]

{ #category : 'parsing' }
SysmelParser >> parseAssociationExpression: state [
	| startPosition key value |
	startPosition := state position.
	key := self parseBinaryExpressionSequence: state.
	
	state peekKind ~= SSTColon ifTrue: [
		^ key
	].
	state advance.
	value := self parseAssociationExpression: state.
	
	^ SysmelParseTreeAssociationNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		key: key;
		value: value;
		yourself
	
]

{ #category : 'parsing' }
SysmelParser >> parseBinaryExpressionSequence: state [
	| startPosition operand elements operatorToken operator |
	startPosition := state position.
	operand := self parseUnaryPrefixExpression: state.
	(self isBinaryExpressionOperator: state peekKind) ifFalse: [
		^ operand
	].

	elements := OrderedCollection with: operand.
	[self isBinaryExpressionOperator: state peekKind] whileTrue: [
		operatorToken := state next.
		operator := SysmelParseTreeLiteralSymbolNode new
			sourcePosition: operatorToken sourcePosition; 
			value: operatorToken getTextValue asSymbol;
			yourself.
		elements add: operator.
		
		operand := self parseUnaryPrefixExpression: state.
		elements add: operand
	].

	^ SysmelParseTreeBinaryExpressionSequenceNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		elements: elements asArray;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseBindExpression: state [
	| startPosition patternExpressionOrValue boundValue |
	startPosition := state position.
	patternExpressionOrValue := self parseFunctionalTypeWithOptionalArgument: state.
	state peekKind = SSTBindOperator ifTrue: [
		state advance.
		boundValue := self parseBindExpression: state.
		^ SysmelParseTreeBindPatternNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			pattern: patternExpressionOrValue;
			value: boundValue;
			yourself
	] ifFalse: [
		^ patternExpressionOrValue
	].
]

{ #category : 'parsing' }
SysmelParser >> parseBindableName: state [
	| startPosition isExistential isMutable isImplicitAndTypeExpression isImplicit typeExpression hasPostTypeExpression isVariadic nameExpression |
	startPosition := state position.
	self assert: state peekKind = SSTColon.
	state advance.
	isExistential := false.
	isMutable := false.
	state peekKind = SSTBang ifTrue: [
		isMutable := true
		state advance
	].

	state peekKind = SSTQuestion ifTrue: [
		isExistential := true.
		state advance
	].

	isImplicitAndTypeExpression := self parseOptionalBindableNameType: state.
	isImplicit := isImplicitAndTypeExpression first.
	typeExpression := isImplicitAndTypeExpression second.
	hasPostTypeExpression := false.
	
	isVariadic := false.
	state peekKind = SSTEllipsis ifTrue: [
		state advance.
		isVariadic := true.
		nameExpression := nil
	] ifFalse: [
		nameExpression := self parseNameExpression: state.
		isImplicitAndTypeExpression := self parseOptionalBindableNameType: state.
		isImplicit := isImplicitAndTypeExpression first.
		typeExpression ifNil: [
			typeExpression := isImplicitAndTypeExpression second.
			hasPostTypeExpression := typeExpression isNotNil.
		].
		
		state peekKind = SSTEllipsis ifTrue: [
			state advance.
			isVariadic := true.
		]
	].
	
	^ SysmelParseTreeBindableNameNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		typeExpression: typeExpression;
		nameExpression: nameExpression;
		isImplicit: isImplicit;
		isExistential: isExistential;
		isVariadic: isVariadic;
		isMutable: isMutable;
		hasPostTypeExpression: hasPostTypeExpression;
		yourself
		
]

{ #category : 'parsing' }
SysmelParser >> parseBlock: state [
	"{"
	| startPosition functionalType body |
	startPosition := state position.
	self assert: state peekKind = SSTLeftCurlyBracket.
	state advance.
	
	functionalType := nil.
	state peekKind = SSTBar ifTrue: [
		state advance.
		state peekKind = SSTBar ifTrue: [ 
			state advance.
			functionalType := SysmelParseTreeFunctionalDependentTypeNode new
				sourcePosition: state currentSourcePosition.
		] ifFalse: [
			functionalType := self parseFunctionalType: state.
			functionalType := state expect: SSTBar addingErrorToNode: functionalType.
			functionalType isFunctionalDependentTypeNode ifFalse: [
				functionalType := SysmelParseTreeFunctionalDependentTypeNode new
					sourcePosition: state currentSourcePosition;
					argumentPattern: functionalType;
					yourself.
			]
		]
	].

	body := self parseSequenceUntilEndOrDelimiter: SSTRightCurlyBracket state: state.
	
	"}" 
	
	body := state expect: SSTRightCurlyBracket addingErrorToNode: body.
	functionalType ifNil: [
		^ SysmelParseTreeLexicalBlockNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			body: body;
			yourself
	] ifNotNil: [
		^ SysmelParseTreeBlockNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			functionalType: functionalType;
			body: body;
			yourself.
	]
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
SysmelParser >> parseCascadeMessage: state [
	| startPosition token selector argument symbolValue arguments firstKeywordSourcePosition lastKeywordSourcePosition keywordToken |
	startPosition := state position.
	token := state peek.
	token kind = SSTIdentifier ifTrue: [
		state advance.
		selector := SysmelParseTreeLiteralSymbolNode new
			sourcePosition: token sourcePosition;
			value: token getTextValue asSymbol;
			yourself.
		^ SysmelParseTreeMessageCascadeMessageNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			selector: selector;
			arguments: #()
	].
	token kind = SSTKeyword ifTrue: [
		symbolValue := ''.
		arguments := OrderedCollection new.
		firstKeywordSourcePosition := state peek sourcePosition.	
		lastKeywordSourcePosition := firstKeywordSourcePosition.
		[ state peekKind = SSTKeyword ] whileTrue: [
			keywordToken := state next.
			lastKeywordSourcePosition := keywordToken sourcePosition.
			symbolValue := symbolValue , keywordToken getTextValue.
		
			argument := self parseUnaryPostfixExpression: state.
			arguments add: argument
		].
	
		selector := SysmelParseTreeLiteralSymbolNode new
			sourcePosition: token sourcePosition;
			value: token getTextValue asSymbol;
			yourself.
		^ SysmelParseTreeMessageCascadeMessageNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			selector: selector;
			arguments: arguments asArray;
			yourself
	].
	(self isBinaryExpressionOperator: token kind) ifTrue: [
		state advance.
		selector := SysmelParseTreeLiteralSymbolNode new
			sourcePosition: token sourcePosition;
			value: token getTextValue asSymbol;
			yourself.
		argument := self parseUnaryPostfixExpression: state.
		^ SysmelParseTreeMessageCascadeMessageNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			selector: selector;
			arguments: { argument };
			yourself
	].

	^ SysmelParseTreeErrorNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		errorMessage: 'Expected a cascaded message.'
]

{ #category : 'parsing' }
SysmelParser >> parseCommaExpression: state [
	| startPosition element elements hasUsedMemento memento |
	startPosition := state position.
	element := self parseAssignmentExpression: state.
	state peekKind ~= SSTComma ifTrue: [
		^ element
	].

	elements := OrderedCollection new.
	elements add: element.
	hasUsedMemento := false.
	[ state peekKind = SSTComma and: [ hasUsedMemento not ] ] whileTrue: [
		state advance.
		memento := state memento.
		element := self parseAssignmentExpression: state.
		element isParseErrorNode ifTrue: [
			state restore: memento.
			hasUsedMemento := true
		] ifFalse: [
			elements add: element
		]
	].

	^ SysmelParseTreeTupleNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		elements: elements asArray;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseDictionary: state [
	self halt
]

{ #category : 'parsing' }
SysmelParser >> parseExpression: state [
	^ self parseBindExpression: state
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
SysmelParser >> parseFunctionalType: state [
	| startPosition argumentPatternOrExpression resultTypeExpression |
	startPosition := state position.
	argumentPatternOrExpression := self parseCommaExpression: state.
	state peekKind = SSTColonColon ifTrue: [
		state advance.
		resultTypeExpression := self parseFunctionalTypeInner: state.
		^ SysmelParseTreeFunctionalDependentTypeNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			argumentPattern: argumentPatternOrExpression;
			resultType: resultTypeExpression
	].
	^ argumentPatternOrExpression
]

{ #category : 'parsing' }
SysmelParser >> parseFunctionalTypeInner: state [
	| startPosition argumentPatternOrExpression resultTypeExpression |
	startPosition := state position.
	argumentPatternOrExpression := self parseTerm: state.
	state peekKind = SSTColonColon ifTrue: [
		state advance.
		resultTypeExpression := self parseFunctionalTypeInner: state.
		^ SysmelParseTreeFunctionalDependentTypeNode new
			sourcePosition: (state sourcePositionFrom: startPosition);
			argumentPattern: argumentPatternOrExpression;
			resultType: resultTypeExpression
	].
	^ argumentPatternOrExpression
]

{ #category : 'parsing' }
SysmelParser >> parseFunctionalTypeWithOptionalArgument: state [
	| startPosition resultTypeExpression |
	state peekKind = SSTColonColon ifTrue: [
		state advance.
		startPosition := state position.
		resultTypeExpression := self parseFunctionalType: state.
		^ SysmelParseTreeFunctionalDependentTypeNode new
			resultType: resultTypeExpression;
			yourself
	] ifFalse: [
		^ self parseFunctionalType: state
	]
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
SysmelParser >> parseKeywordApplication: state [
	| startPosition symbolValue arguments firstKeywordSourcePosition lastKeywordSourcePosition keywordToken argument functionIdentifier |
	self assert: state peekKind = SSTKeyword.
	startPosition := state position.
	
	symbolValue := ''.
	arguments := OrderedCollection new.
	firstKeywordSourcePosition := state peek sourcePosition.
	lastKeywordSourcePosition := firstKeywordSourcePosition.
	
	[ state peekKind = SSTKeyword ] whileTrue: [
		keywordToken := state next.
		lastKeywordSourcePosition := keywordToken sourcePosition.
		symbolValue := symbolValue , keywordToken getTextValue.
		
		argument := self parseAssociationExpression: state.
		arguments add: argument
	].

	functionIdentifier := SysmelParseTreeLiteralSymbolNode new
		sourcePosition: (firstKeywordSourcePosition to: lastKeywordSourcePosition);
		value: symbolValue asSymbol;
		yourself.
	^ SysmelParseTreeMessageSendNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		selector: functionIdentifier;
		arguments: arguments asArray;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseKeywordMessageSend: state [
	| startPosition receiver symbolValue arguments firstKeywordSourcePosition lastKeywordSourcePosition keywordToken argument selector |
	startPosition := state position.
	receiver := self parseAssociationExpression: state.
	state peekKind ~= SSTKeyword ifTrue: [ ^ receiver ].
	
	symbolValue := ''.
	arguments := OrderedCollection new.
	firstKeywordSourcePosition := state peek sourcePosition.
	lastKeywordSourcePosition := firstKeywordSourcePosition.
	
	[ state peekKind = SSTKeyword ] whileTrue: [
		keywordToken := state next.
		lastKeywordSourcePosition := keywordToken sourcePosition.
		symbolValue := symbolValue , keywordToken getTextValue.
		
		argument := self parseAssociationExpression: state.
		arguments add: argument
	].

	selector := SysmelParseTreeLiteralSymbolNode new
		sourcePosition: (firstKeywordSourcePosition to: lastKeywordSourcePosition);
		value: symbolValue asSymbol;
		yourself.
	^ SysmelParseTreeMessageSendNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		receiver: receiver;
		selector: selector;
		arguments: arguments asArray;
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
SysmelParser >> parseLowPrecedenceExpression: state [
	state peekKind = SSTKeyword ifTrue: [
		^ self parseKeywordApplication: state
	] ifFalse: [
		^ self parseMessageCascade: state
	]
	
]

{ #category : 'parsing' }
SysmelParser >> parseMessageCascade: state [
	| startPosition firstMessage receiverAndFirstCascaded receiver firstCascaded cascaded |
	startPosition := state position.
	firstMessage := self parseKeywordMessageSend: state.
	state peekKind ~= SSTSemicolon ifTrue: [
		^ firstMessage
	].

	receiverAndFirstCascaded := firstMessage asMessageSendCascadeReceiverAndFirstMessage.
	receiver := receiverAndFirstCascaded first.
	firstCascaded := receiverAndFirstCascaded second.
	cascaded := OrderedCollection new.
	firstCascaded ifNotNil: [ cascaded add: firstCascaded ].
	
	[state peekKind = SSTSemicolon ] whileTrue: [
		state advance.
		cascaded add: (self parseCascadeMessage: state)
	].

	^ SysmelParseTreeMessageCascadeNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		receiver: receiver;
		messages: cascaded asArray;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseNameExpression: state [
	| token |
	state peekKind = SSTIdentifier ifTrue: [
		token := state next.
		^ SysmelParseTreeLiteralSymbolNode new
			sourcePosition: token sourcePosition;
			value: token getTextValue asSymbol;
			yourself
	] ifFalse: [
		^ SysmelParseTreeErrorNode new
			sourcePosition: state currentSourcePosition;
			errorMessage: 'Expected a bindable name.'
	]
]

{ #category : 'parsing' }
SysmelParser >> parseOptionalBindableNameType: state [
	| typeExpression |
	state peekKind = SSTLeftBracket ifTrue: [ 
		state advance.
		typeExpression := self parseExpression: state.
		typeExpression := state expect: SSTRightBracket addingErrorToNode: typeExpression.
		^ { true . typeExpression }
	].
	state peekKind = SSTLeftParent ifTrue: [ 
		state advance.
		typeExpression := self parseExpression: state.
		typeExpression := state expect: SSTRightParent addingErrorToNode: typeExpression.
		^ { false . typeExpression }
	].

	^ { false. nil }
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
SysmelParser >> parseQuasiQuote: state [
	| startPosition term |
	startPosition := state position.
	self assert: state peekKind = SSTQuasiQuote.
	state advance.
	term := self parseUnaryPrefixExpression: state.

	^ SysmelParseTreeQuasiQuoteNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		term: term;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseQuasiUnquote: state [
	| startPosition term |
	startPosition := state position.
	self assert: state peekKind = SSTQuasiUnquote.
	state advance.
	term := self parseUnaryPrefixExpression: state.

	^ SysmelParseTreeQuasiUnquoteNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		term: term;
		yourself
]

{ #category : 'parsing' }
SysmelParser >> parseQuote: state [
	| startPosition term |
	startPosition := state position.
	self assert: state peekKind = SSTQuote.
	state advance.
	term := self parseUnaryPrefixExpression: state.

	^ SysmelParseTreeQuoteNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		term: term;
		yourself
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
SysmelParser >> parseSplice: state [
	| startPosition term |
	startPosition := state position.
	self assert: state peekKind = SSTSplice.
	state advance.
	term := self parseUnaryPrefixExpression: state.

	^ SysmelParseTreeSpliceNode new
		sourcePosition: (state sourcePositionFrom: startPosition);
		term: term;
		yourself
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
SysmelParser >> parseUnaryPostfixExpression: state [
	| startPosition receiver postfixTokens token selector currentKind arguments argument |
	startPosition := state position.
	receiver := self parseTerm: state.
	
	postfixTokens := { SSTIdentifier. SSTLeftParent . SSTLeftBracket. SSTLeftCurlyBracket. SSTByteArrayStart. SSTDictionaryStart}.
	[ postfixTokens includes: state peekKind ] whileTrue: [
		token := state peek.
		currentKind := token kind.
		currentKind = SSTIdentifier ifTrue: [
			state advance.
			selector := SysmelParseTreeLiteralSymbolNode new
				sourcePosition: token sourcePosition;
				value: token getTextValue asSymbol;
				yourself.
			receiver := SysmelParseTreeMessageSendNode new
				sourcePosition: (receiver sourcePosition to: selector sourcePosition);
				receiver: receiver;
				selector: selector;
				arguments: #();
				yourself
		].
		currentKind = SSTLeftParent ifTrue: [
			state advance.
			arguments := self parseExpressionListUntilEndOrDelimiter: SSTRightParent state: state.
			state peekKind = SSTRightParent ifTrue: [
				state advance
			] ifFalse: [
				arguments add: (SysmelParseTreeErrorNode new
					sourcePosition: state currentSourcePosition;
					errorMessage: 'Expected a right parenthesis')
			].
			receiver := SysmelParseTreeApplicationNode new
				sourcePosition: (state sourcePositionFrom: startPosition);
				functional: receiver;
				arguments: arguments asArray;
				yourself.
		].
		currentKind = SSTLeftBracket ifTrue: [
			state advance.
			arguments := self parseExpressionListUntilEndOrDelimiter: SSTRightBracket state: state.
			state peekKind = SSTRightBracket ifTrue: [
				state advance
			] ifFalse: [
				arguments add: (SysmelParseTreeErrorNode new
					sourcePosition: state currentSourcePosition;
					errorMessage: 'Expected a right parenthesis')
			].
			receiver := SysmelParseTreeApplicationNode new
				sourcePosition: (state sourcePositionFrom: startPosition);
				functional: receiver;
				arguments: arguments asArray;
				yourself.
		].
		
		currentKind = SSTByteArrayStart ifTrue: [
			state advance.
			arguments := self parseExpressionListUntilEndOrDelimiter: SSTRightBracket state: state.
			state peekKind = SSTRightBracket ifTrue: [
				state advance
			] ifFalse: [
				arguments add: (SysmelParseTreeErrorNode new
					sourcePosition: state currentSourcePosition;
					errorMessage: 'Expected a right parenthesis')
			].
			receiver := SysmelParseTreeApplicationNode new
				sourcePosition: (state sourcePositionFrom: startPosition);
				functional: receiver;
				arguments: arguments asArray;
				yourself.
		].
	
		currentKind = SSTLeftCurlyBracket ifTrue: [
			argument := self parseBlock: state.
			receiver := SysmelParseTreeApplicationNode new
				sourcePosition: (state sourcePositionFrom: startPosition);
				functional: receiver;
				arguments: {argument};
				yourself.
		].
		currentKind = SSTDictionaryStart ifTrue: [
			argument := self parseDictionary: state.
			receiver := SysmelParseTreeApplicationNode new
				sourcePosition: (state sourcePositionFrom: startPosition);
				functional: receiver;
				arguments: {argument};
				yourself.
		].
	].

	^ receiver
]

{ #category : 'parsing' }
SysmelParser >> parseUnaryPrefixExpression: state [
	state peekKind = SSTQuote ifTrue: [ ^ self parseQuote: state ].
	state peekKind = SSTQuasiQuote ifTrue: [ ^ self parseQuasiQuote: state ].
	state peekKind = SSTQuasiUnquote ifTrue: [ ^ self parseQuasiUnquote: state ].
	state peekKind = SSTQuote ifTrue: [ ^ self parseQuote: state ].
	state peekKind = SSTSplice ifTrue: [ ^ self parseSplice: state ].
	^ self parseUnaryPostfixExpression: state
]

{ #category : 'parsing' }
SysmelParser >> parseWithState: state [
	^ self parseTopLevelExpression: state
]
