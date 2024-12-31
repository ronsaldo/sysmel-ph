"
A SysmelScannerTest is a test class for testing the behavior of SysmelScanner
"
Class {
	#name : 'SysmelScannerTest',
	#superclass : 'TestCase',
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd-Tests-Scanner',
	#package : 'Sysmel-FrontEnd-Tests',
	#tag : 'Scanner'
}

{ #category : 'tests' }
SysmelScannerTest >> scanTokenKinds: aString [
	| sourceCode scannerResult |
	sourceCode := SysmelSourceCode forSysmelText: aString.
	scannerResult := SysmelScanner new scanSourceCode: sourceCode.
	^ scannerResult asArray collect: [ :each | each kind ]
]

{ #category : 'tests' }
SysmelScannerTest >> testCharacter [
	self assert: (self scanTokenKinds: '''A''') asArray equals: { SSTCharacter . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testEmpty [
	self assert: (self scanTokenKinds: '') asArray equals: { SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testFloat [
	self assert: (self scanTokenKinds: '42.5') asArray equals: { SSTFloat . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '42.5e+12') asArray equals: { SSTFloat . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '42.5E+12') asArray equals: { SSTFloat . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '42.5e-12') asArray equals: { SSTFloat . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '42.5E-12') asArray equals: { SSTFloat . SSTEndOfSource }.
]

{ #category : 'tests' }
SysmelScannerTest >> testIdentifier [
	self assert: (self scanTokenKinds: 'helloIdentifier') asArray equals: { SSTIdentifier . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testIncompleteMultilineComment [
	self assert: (self scanTokenKinds: '#* comment') asArray equals: { SSTError . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testIncompleteString [
	self assert: (self scanTokenKinds: '"Hello World') asArray equals: { SSTError . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testInteger [
	self assert: (self scanTokenKinds: '1234') asArray equals: { SSTNat . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '2r01010') asArray equals: { SSTNat . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '16rC0DE') asArray equals: { SSTNat . SSTEndOfSource }.
]

{ #category : 'tests' }
SysmelScannerTest >> testKeyword [
	self assert: (self scanTokenKinds: 'keyword:') asArray equals: { SSTKeyword . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testKeywordSymbol [
	self assert: (self scanTokenKinds: '#keyword:') asArray equals: { SSTSymbol . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testLeftSpecialBrackets [
	self assert: (self scanTokenKinds: '#[') asArray equals: { SSTByteArrayStart . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '#{') asArray equals: { SSTDictionaryStart . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '#(') asArray equals: { SSTLiteralArrayStart . SSTEndOfSource }.

]

{ #category : 'tests' }
SysmelScannerTest >> testMultiKeyword [
	self assert: (self scanTokenKinds: 'keyword:with:') asArray equals: { SSTMultiKeyword . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testMultiKeywordSymbol [
	self assert: (self scanTokenKinds: '#keyword:with:') asArray equals: { SSTSymbol . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testMultilineComment [
	self assert: (self scanTokenKinds: '#* comment *#') asArray equals: { SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testOperator [
	self assert: (self scanTokenKinds: '+') asArray equals: { SSTOperator . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '-') asArray equals: { SSTOperator . SSTEndOfSource }.
]

{ #category : 'tests' }
SysmelScannerTest >> testOperatorSymbol [
	self assert: (self scanTokenKinds: '#<') asArray equals: { SSTSymbol . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '#|') asArray equals: { SSTSymbol . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '#+') asArray equals: { SSTSymbol . SSTEndOfSource }.
]

{ #category : 'tests' }
SysmelScannerTest >> testPunctuation [
	self assert: (self scanTokenKinds: '( )') asArray equals: { SSTLeftParent. SSTRightParent. SSTEndOfSource }.
	self assert: (self scanTokenKinds: '[ ]') asArray equals: { SSTLeftBracket . SSTRightBracket . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '{ }') asArray equals: { SSTLeftCurlyBracket . SSTRightCurlyBracket . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '. ... ; : |') asArray equals: { SSTDot. SSTEllipsis. SSTSemicolon. SSTColon. SSTBar . SSTEndOfSource }.
	self assert: (self scanTokenKinds: '< >') asArray equals: { SSTLessThan. SSTGreaterThan. SSTEndOfSource }.
]

{ #category : 'tests' }
SysmelScannerTest >> testString [
	self assert: (self scanTokenKinds: '"Hello World"') asArray equals: { SSTString . SSTEndOfSource }
]

{ #category : 'tests' }
SysmelScannerTest >> testStringSymbol [
	self assert: (self scanTokenKinds: '#"Hello Symbol"') asArray equals: { SSTSymbol . SSTEndOfSource }.
]

{ #category : 'tests' }
SysmelScannerTest >> testSymbol [
	self assert: (self scanTokenKinds: '#helloIdentifier') asArray equals: { SSTSymbol . SSTEndOfSource }
]
