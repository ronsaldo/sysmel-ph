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
	^ collectedErrors isEmpty
]

{ #category : 'initialization' }
SysmelParseTreeErrorVisitor >> initialize [
	collectedErrors := OrderedCollection new.
	
]
