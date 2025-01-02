Class {
	#name : 'SysmelParseTreeBindableNameNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'typeExpression',
		'nameExpression',
		'isImplicit',
		'isExistential',
		'isVariadic',
		'isMutable',
		'hasPostTypeExpression'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeBindableNameNode >> accept: visitor [
	^ visitor visitBindableNameNode: self
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> hasPostTypeExpression [

	^ hasPostTypeExpression
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> hasPostTypeExpression: anObject [

	hasPostTypeExpression := anObject
]

{ #category : 'testing' }
SysmelParseTreeBindableNameNode >> isBindableNameNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isExistential [

	^ isExistential
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isExistential: anObject [

	isExistential := anObject
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isImplicit [

	^ isImplicit
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isImplicit: anObject [

	isImplicit := anObject
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isMutable [

	^ isMutable
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isMutable: anObject [

	isMutable := anObject
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isVariadic [

	^ isVariadic
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> isVariadic: anObject [

	isVariadic := anObject
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> nameExpression [

	^ nameExpression
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> nameExpression: anObject [

	nameExpression := anObject
]

{ #category : 'testing' }
SysmelParseTreeBindableNameNode >> parseAndUnpackArgumentsPattern [
	^ {{self}. isExistential . isVariadic}
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> typeExpression [

	^ typeExpression
]

{ #category : 'accessing' }
SysmelParseTreeBindableNameNode >> typeExpression: anObject [

	typeExpression := anObject
]
