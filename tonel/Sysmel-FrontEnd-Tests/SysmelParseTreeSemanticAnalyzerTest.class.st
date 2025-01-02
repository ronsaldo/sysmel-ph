"
A SysmelParseTreeSemanticAnalyzerTest is a test class for testing the behavior of SysmelParseTreeSemanticAnalyzer
"
Class {
	#name : 'SysmelParseTreeSemanticAnalyzerTest',
	#superclass : 'TestCase',
	#instVars : [
		'module'
	],
	#category : 'Sysmel-FrontEnd-Tests-Analysis',
	#package : 'Sysmel-FrontEnd-Tests',
	#tag : 'Analysis'
}

{ #category : 'parsing' }
SysmelParseTreeSemanticAnalyzerTest >> parseAndAnalyse: sourceString [
	| ast environment asgAndRegion |
	ast := self parseSourceStringWithoutError: sourceString.
	environment := module makeEnvironmentFor: ast.

	asgAndRegion := SysmelParseTreeSemanticAnalyzer new
			analyzeAST: ast withEnvironment: environment region: SoNRegionGraphNode new.
	^ asgAndRegion
]

{ #category : 'parsing' }
SysmelParseTreeSemanticAnalyzerTest >> parseAndAnalyseASG: sourceString [
	^ (self parseAndAnalyse: sourceString) first
]

{ #category : 'parsing' }
SysmelParseTreeSemanticAnalyzerTest >> parseSourceString: sourceString [
	| sourceCode |
	sourceCode := SysmelSourceCode new
		text: sourceString;
		yourself.
	^ SysmelParser new parseSourceCode: sourceCode
]

{ #category : 'parsing' }
SysmelParseTreeSemanticAnalyzerTest >> parseSourceStringWithoutError: string [
	| ast |
	ast := self parseSourceString: string.
	self assert: (SysmelParseTreeErrorVisitor new checkAndPrintErrors: ast).
	^ ast
]

{ #category : 'running' }
SysmelParseTreeSemanticAnalyzerTest >> setUp [
	module := SysmelModule named: #Testing.
	
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testApplication [ 
	| asg asgAndRegion region |
	asgAndRegion := self parseAndAnalyse: 'Object()'.
	asg := asgAndRegion first.
	region := asgAndRegion second.
	
	self assert: asg isApplicationGraphNode.
	self assert: asg functional isLiteralValueGraphNode.
	self assert: asg arguments size equals: 0.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testAssignment [ 
	| asg asgAndRegion region |
	asgAndRegion := self parseAndAnalyse: ':!x := 42. x := 5'.
	asg := asgAndRegion first.
	region := asgAndRegion second.
	
	self assert: asg isSequencingGraphNode.
	self assert: asg elements size equals: 2.
	self assert: asg elements first isLiteralValueGraphNode.
	self assert: asg elements first value equals: 42.

	self assert: asg elements second isLiteralValueGraphNode.
	self assert: asg elements second value equals: 5.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testAssociation [ 
	| asg |
	asg := self parseAndAnalyseASG: '1 : 2'.
	
	self assert: asg isAssociationGraphNode.
	self assert: asg key isLiteralValueGraphNode.
	self assert: asg key value equals: 1.

	self assert: asg value isLiteralValueGraphNode.
	self assert: asg value value equals: 2.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testBinaryExpressionSequence [
	| asg |
	asg := self parseAndAnalyseASG: '1+2'.
	self assert: asg isSendMessageGraphNode.
	self assert: asg receiver value equals: 1.
	self assert: asg selector value equals: #+.
	self assert: asg arguments first value equals: 2
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testBindableAssignment [ 
	| asg |
	asg := self parseAndAnalyseASG: ':x := 42'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 42.
	self assert: asg type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testBindableAssignment2 [
	| asg |
	asg := self parseAndAnalyseASG: ':x := 42. x'.
	self assert: asg isSequencingGraphNode.
	self assert: asg elements size equals: 2.
	self assert: asg elements first value equals: 42.
	self assert: asg elements first type equals: Integer.
	
	self assert: asg elements second value equals: 42.
	self assert: asg elements second type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary [
	| asg |
	asg := self parseAndAnalyseASG: '#{}'.
	
	self assert: asg isDictionaryGraphNode.
	self assert: asg elements size equals: 0.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary1 [
	| asg |
	asg := self parseAndAnalyseASG: '#{First: 1}'.
	
	self assert: asg isDictionaryGraphNode.
	self assert: asg elements size equals: 1.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary2 [
	| asg |
	asg := self parseAndAnalyseASG: '#{First: 1. Second: 2}'.
	
	self assert: asg isDictionaryGraphNode.
	self assert: asg elements size equals: 2.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary3 [
	| asg |
	asg := self parseAndAnalyseASG: '#{First: 1. Second: 2. #Third : 3}'.
	
	self assert: asg isDictionaryGraphNode.
	self assert: asg elements size equals: 3.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testEmpty [
	| asg |
	asg := self parseAndAnalyseASG: ''.
	self assert: asg isSequencingGraphNode.
	self assert: asg elements isEmpty.
	self assert: asg type isVoid.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testIfStatement [
	| asg |
	asg := self parseAndAnalyse: 'if: true then: 1 else: 2'.
	self assert: asg first isPhiGraphNode.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testIntrinsicIdentifierReference [ 
	| asg |
	asg := self parseAndAnalyseASG: 'Object'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: Object.
	self assert: asg type equals: Object class.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLexicalBlock [ 
	| asg |
	asg := self parseAndAnalyseASG: '{42}'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 42.
	self assert: asg type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralCharacter [ 
	| asg |
	asg := self parseAndAnalyseASG: '''A'''.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: $A.
	self assert: asg type equals: Character.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralFloat [
	| asg |
	asg := self parseAndAnalyseASG: '42.5'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 42.5.
	self assert: asg type equals: Float.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralInteger [
	| asg |
	asg := self parseAndAnalyseASG: '42'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 42.
	self assert: asg type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralInteger2 [
	| asg |
	asg := self parseAndAnalyseASG: '42. 5'.
	self assert: asg isSequencingGraphNode.
	self assert: asg elements size equals: 2.
	
	self assert: asg elements first value equals: 42.
	self assert: asg elements first type equals: Integer.
	
	self assert: asg elements second value equals: 5.
	self assert: asg elements second type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralString [
	| asg |
	asg := self parseAndAnalyseASG: '"Hello World"'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: 'Hello World'.
	self assert: asg type equals: String.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralSymbol [
	| asg |
	asg := self parseAndAnalyseASG: '#helloSymbol'.
	self assert: asg isLiteralValueGraphNode.
	self assert: asg value equals: #helloSymbol.
	self assert: asg type equals: Symbol.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testMessageCascade [
	| asgAndRegions regions |
	asgAndRegions := self parseAndAnalyse: '45;negated;yourself'.
	regions := asgAndRegions second.
	self assert: regions instructions size equals: 2.
	self assert: regions instructions first isSendMessageGraphNode.
	self assert: regions instructions first selector equals: #negated.

	self assert: regions instructions second isSendMessageGraphNode.
	self assert: regions instructions second selector equals: #yourself.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple [
	| asg |
	asg := self parseAndAnalyseASG: '()'.
	self assert: asg isTupleGraphNode.
	self assert: asg elements size equals: 0
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple1 [
	| asg |
	asg := self parseAndAnalyseASG: '42,'.
	self assert: asg isTupleGraphNode.
	self assert: asg elements size equals: 1
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple2 [
	| asg |
	asg := self parseAndAnalyseASG: '42, 5'.
	self assert: asg isTupleGraphNode.
	self assert: asg elements size equals: 2
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testUnaryMessageSend [
	| asg |
	asg := self parseAndAnalyseASG: '1 negated'.
	self assert: asg isSendMessageGraphNode.
	self assert: asg receiver value equals: 1.
	self assert: asg selector value equals: #negated.
	self assert: asg arguments size equals: 0
]
