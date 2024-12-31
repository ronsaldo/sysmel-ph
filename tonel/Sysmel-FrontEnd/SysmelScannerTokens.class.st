"
I have a list of the allowed scanner tokens.
"
Class {
	#name : 'SysmelScannerTokens',
	#superclass : 'SharedPool',
	#classVars : [
		'SSTAssignment',
		'SSTBang',
		'SSTBar',
		'SSTBindOperator',
		'SSTByteArrayStart',
		'SSTCharacter',
		'SSTColon',
		'SSTColonColon',
		'SSTComma',
		'SSTDictionaryStart',
		'SSTDot',
		'SSTEllipsis',
		'SSTEndOfSource',
		'SSTError',
		'SSTFloat',
		'SSTGreaterThan',
		'SSTIdentifier',
		'SSTKeyword',
		'SSTLeftBracket',
		'SSTLeftCurlyBracket',
		'SSTLeftParent',
		'SSTLessThan',
		'SSTLiteralArrayStart',
		'SSTMultiKeyword',
		'SSTNat',
		'SSTOperator',
		'SSTQuasiQuote',
		'SSTQuasiUnquote',
		'SSTQuestion',
		'SSTQuote',
		'SSTRightBracket',
		'SSTRightCurlyBracket',
		'SSTRightParent',
		'SSTSemicolon',
		'SSTSplice',
		'SSTStar',
		'SSTString',
		'SSTSymbol'
	],
	#category : 'Sysmel-FrontEnd-Scanner',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Scanner'
}

{ #category : 'class initialization' }
SysmelScannerTokens class >> initialize [
	self tokenNames doWithIndex: [ :rawTokenName :index |
		| tokenName |
		tokenName := ('SST' , rawTokenName) asSymbol. 
		(self hasClassVarNamed: tokenName) ifFalse: [
			self addClassVarNamed: tokenName
		].
		self classVarNamed: tokenName put: index
	]
]

{ #category : 'accessing' }
SysmelScannerTokens class >> tokenNames [
	^ #(EndOfSource Error

		Character Float Identifier Nat Keyword MultiKeyword Operator
		String Symbol

		LeftParent RightParent LeftBracket RightBracket LeftCurlyBracket RightCurlyBracket

		LessThan GreaterThan Star Question Bang Colon ColonColon Bar Assignment Semicolon
		Comma Dot Ellipsis BindOperator Quote QuasiQuote QuasiUnquote Splice

		ByteArrayStart DictionaryStart LiteralArrayStart)
]
