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
	| asg region seaOfNodes applicationNode |
	seaOfNodes := self parseAndAnalyse: ':id(:(Integer)x :: Integer) := x. id(45)'.
	region := seaOfNodes startingRegion.
	applicationNode := region instructions first. 
	
	self assert: applicationNode isApplicationGraphNode.
	self assert: applicationNode functional isLambdaNode.
	self assert: applicationNode arguments size equals: 1.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testAssignment [ 
	| instructions region seaOfNodes |
	seaOfNodes := self parseAndAnalyse: ':!x := 42. x := 5'.
	region := seaOfNodes startingRegion.
	instructions := region instructions.
	
	self assert: instructions first isAllocaGraphNode.
	self assert: instructions second isStoreValueGraphNode.
	self assert: instructions third isStoreValueGraphNode.
	self assert: instructions fourth isSequencingGraphNode.

]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testAssociation [ 
	| asg instructions |
	asg := self parseAndAnalyse: '1 : 2'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 1.

	self assert: instructions second isLiteralValueGraphNode.
	self assert: instructions second value equals: 2.

	self assert: instructions third isAssociationGraphNode.
	self assert: instructions third key equals: instructions first.
	self assert: instructions third value equals: instructions second.
	
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testBinaryExpressionSequence [
	| asg instructions |
	asg := self parseAndAnalyse: '1+2'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 1.

	self assert: instructions second isLiteralValueGraphNode.
	self assert: instructions second value equals: #+.

	self assert: instructions third isLiteralValueGraphNode.
	self assert: instructions third value equals: 2.

	self assert: instructions fourth isSendMessageGraphNode.
	self assert: instructions fourth receiver equals: instructions first.
	self assert: instructions fourth selector equals: instructions second.
	self assert: instructions fourth arguments equals: {instructions third}.

]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testBindableAssignment [ 
	| asg instructions |
	asg := self parseAndAnalyse: ':x := 42'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 42.
	self assert: instructions first type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testBindableAssignment2 [
	| asg instructions |
	asg := self parseAndAnalyse: ':x := 42. x'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 42.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary [
	| asg instructions |
	asg := self parseAndAnalyse: '#{}'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	
	self assert: instructions first isDictionaryGraphNode.
	self assert: instructions first elements size equals: 0.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary1 [
	| asg instructions |
	asg := self parseAndAnalyse: '#{First: 1}'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: #First.

	self assert: instructions second isLiteralValueGraphNode.
	self assert: instructions second value equals: 1.

	self assert: instructions third isAssociationGraphNode.
	self assert: instructions third key equals: instructions first.
	self assert: instructions third value equals: instructions second.
		
	self assert: instructions fourth isDictionaryGraphNode.
	self assert: instructions fourth elements size equals: 1.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary2 [
	| asg instructions |
	asg := self parseAndAnalyse: '#{First: 1. Second: 2}'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: #First.

	self assert: instructions second isLiteralValueGraphNode.
	self assert: instructions second value equals: 1.

	self assert: instructions third isAssociationGraphNode.
	self assert: instructions third key equals: instructions first.
	self assert: instructions third value equals: instructions second.

	self assert: instructions fourth isLiteralValueGraphNode.
	self assert: instructions fourth value equals: #Second.

	self assert: instructions fifth isLiteralValueGraphNode.
	self assert: instructions fifth value equals: 2.

	self assert: instructions sixth isAssociationGraphNode.
	self assert: instructions sixth key equals: instructions fourth.
	self assert: instructions sixth value equals: instructions fifth.
		
	self assert: instructions seventh isDictionaryGraphNode.
	self assert: instructions seventh elements size equals: 2.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testDictionary3 [
	| asg instructions |
	asg := self parseAndAnalyse: '#{First: 1. Second: 2. #Third : 3}'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: #First.

	self assert: instructions second isLiteralValueGraphNode.
	self assert: instructions second value equals: 1.

	self assert: instructions third isAssociationGraphNode.
	self assert: instructions third key equals: instructions first.
	self assert: instructions third value equals: instructions second.

	self assert: instructions fourth isLiteralValueGraphNode.
	self assert: instructions fourth value equals: #Second.

	self assert: instructions fifth isLiteralValueGraphNode.
	self assert: instructions fifth value equals: 2.

	self assert: instructions sixth isAssociationGraphNode.
	self assert: instructions sixth key equals: instructions fourth.
	self assert: instructions sixth value equals: instructions fifth.

	self assert: instructions seventh isLiteralValueGraphNode.
	self assert: instructions seventh value equals: #Third.

	self assert: instructions eighth isLiteralValueGraphNode.
	self assert: instructions eighth value equals: 3.

	self assert: instructions ninth isAssociationGraphNode.
	self assert: instructions ninth key equals: instructions seventh.
	self assert: instructions ninth value equals: instructions eighth.
			
	self assert: (instructions at: 10) isDictionaryGraphNode.
	self assert: (instructions at: 10) elements size equals: 3.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testEmpty [
	| asg instructions |
	asg := self parseAndAnalyse: ''.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: SysmelVoidType uniqueInstance.
	self assert: instructions first type isVoidType.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testFunctionalType [
	| node instructions |
	node := self parseAndAnalyse: ':(Integer)x :: Integer'.
	instructions := node scheduleInstructions enumeratedInstructions.
	
	self assert: instructions first isPiNode.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testIfStatement [
	| asg instructions |
	asg := self parseAndAnalyse: 'if: true then: 1 else: 2'.
	instructions := asg scheduleInstructions enumeratedInstructions.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testIntrinsicIdentifierReference [ 
	| asg instructions |
	asg := self parseAndAnalyse: 'Object'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: Object.
	self assert: instructions first type equals: Object class.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLambdaFunction [
	| node instructions |
	node := self parseAndAnalyse: '(:(Integer)x :: Integer) := x*x'.
	instructions := node scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLambdaNode.
	self assert: instructions second isBasicBlockTerminator.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLexicalBlock [ 
	| asg instructions |
	asg := self parseAndAnalyse: '{42}'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 42.
	self assert: instructions first type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralCharacter [ 
	| asg instructions |
	asg := self parseAndAnalyse: '''A'''.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: $A.
	self assert: instructions first type equals: Character.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralFloat [
	| asg instructions |
	asg := self parseAndAnalyse: '42.5'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 42.5.
	self assert: instructions first type equals: Float.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralInteger [
	| asg instructions |
	asg := self parseAndAnalyse: '42'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 42.
	self assert: instructions first type equals: Integer.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralInteger2 [
	| asg instructions |
	asg := self parseAndAnalyse: '42. 5'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first value equals: 42.
	self assert: instructions first type equals: Integer.
	
	self assert: instructions second value equals: 5.
	self assert: instructions second type equals: Integer.

	self assert: instructions third isSequencingGraphNode.
	self assert: instructions third elements size equals: 2.
	

]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralString [
	| asg instructions |
	asg := self parseAndAnalyse: '"Hello World"'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 'Hello World'.
	self assert: instructions first type equals: String.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testLiteralSymbol [
	| asg instructions |
	asg := self parseAndAnalyse: '#helloSymbol'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: #helloSymbol.
	self assert: instructions first type equals: Symbol.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testMessageCascade [
	| seaOfNodes regions |
	seaOfNodes := self parseAndAnalyse: '45;negated;yourself'.
	regions := seaOfNodes startingRegion .
	self assert: regions instructions size equals: 2.
	self assert: regions instructions first isSendMessageGraphNode.
	self assert: regions instructions first selector value equals: #negated.

	self assert: regions instructions second isSendMessageGraphNode.
	self assert: regions instructions second selector value equals: #yourself.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testNamedFunction [
	| node instructions |
	node := self parseAndAnalyse: ':square(:(Integer)x :: Integer) := x*x'.
	instructions := node scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLambdaNode.
	self assert: instructions second isBasicBlockTerminator.
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple [
	| asg instructions |
	asg := self parseAndAnalyse: '()'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isTupleGraphNode.
	self assert: instructions first elements size equals: 0
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple1 [
	| asg instructions |
	asg := self parseAndAnalyse: '42,'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	
	self assert: instructions first isLiteralValueGraphNode .
	self assert: instructions first value equals: 42.
	
	self assert: instructions second isTupleGraphNode.
	self assert: instructions second elements size equals: 1.
	self assert: instructions second elements first equals: instructions first
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testTuple2 [
	| asg instructions |
	asg := self parseAndAnalyse: '42, 5'.
	instructions := asg scheduleInstructions enumeratedInstructions.
	
	self assert: instructions first isLiteralValueGraphNode .
	self assert: instructions first value equals: 42.

	self assert: instructions second isLiteralValueGraphNode .
	self assert: instructions second value equals: 5.
	
	self assert: instructions third isTupleGraphNode.
	self assert: instructions third elements size equals: 2.
	self assert: instructions third elements first equals: instructions first
]

{ #category : 'tests' }
SysmelParseTreeSemanticAnalyzerTest >> testUnaryMessageSend [
	| asg instructions |
	asg := self parseAndAnalyse: '1 negated'.
	instructions := asg scheduleInstructions enumeratedInstructions.

	self assert: instructions first isLiteralValueGraphNode.
	self assert: instructions first value equals: 1.
	self assert: instructions first type equals: Integer.

	self assert: instructions second isLiteralValueGraphNode.
	self assert: instructions second value equals: #negated.
	self assert: instructions second type equals: Symbol.
	
	self assert: instructions third isSendMessageGraphNode.
	self assert: instructions third receiver value equals: 1.
	self assert: instructions third selector value equals: #negated.
	self assert: instructions third arguments size equals: 0
]
