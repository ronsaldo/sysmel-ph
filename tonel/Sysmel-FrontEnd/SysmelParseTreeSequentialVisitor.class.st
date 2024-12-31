Class {
	#name : 'SysmelParseTreeSequentialVisitor',
	#superclass : 'SysmelParseTreeVisitor',
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeSequentialVisitor >> visitSequenceNode: node [
	node elements do: [ :each | self visitNode: each ]
]
