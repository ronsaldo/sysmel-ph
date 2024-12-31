"
A SysmelScannerTest is a test class for testing the behavior of SysmelScanner
"
Class {
	#name : 'SysmelScannerTest',
	#superclass : 'TestCase',
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd-Tests',
	#package : 'Sysmel-FrontEnd-Tests'
}

{ #category : 'as yet unclassified' }
SysmelScannerTest >> scanTokenKinds: aString [
	| sourceCode scannerResult |
	sourceCode := SysmelSourceCode forSysmelText: aString.
	scannerResult := SysmelScanner new scanSourceCode: sourceCode.
	^ scannerResult asArray collect: [ :each | each kind ]
]

{ #category : 'as yet unclassified' }
SysmelScannerTest >> testEmpty [
	self assert: (self scanTokenKinds: '') asArray equals: { SSTEndOfSource }
]
