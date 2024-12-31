Class {
	#name : 'SysmelParseTreeErrorVisitor',
	#superclass : 'SysmelParseTreeSequentialVisitor',
	#instVars : [
		'collectedErrors'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'initialization' }
SysmelParseTreeErrorVisitor >> checkAndPrintErrors: ast [
	ast accept: self.
	collectedErrors do: [ :each | Transcript show: each errorMessage; cr. ].
	^ collectedErrors isEmpty
]

{ #category : 'accessing' }
SysmelParseTreeErrorVisitor >> collectedErrors [
]

{ #category : 'initialization' }
SysmelParseTreeErrorVisitor >> initialize [
	collectedErrors := OrderedCollection new.
	
]

{ #category : 'visiting' }
SysmelParseTreeErrorVisitor >> visitParseErrorNode: node [
	collectedErrors add: node.
	super visitParseErrorNode: node
]
