"
I encapsulate a specific range of lines and columns in the source code.
"
Class {
	#name : 'SysmelSourcePosition',
	#superclass : 'Object',
	#instVars : [
		'sourceCode',
		'startIndex',
		'endIndex',
		'startLine',
		'startColumn',
		'endLine',
		'endColumn'
	],
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd-Scanner',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Scanner'
}

{ #category : 'accessing' }
SysmelSourcePosition >> endColumn [

	^ endColumn
]

{ #category : 'accessing' }
SysmelSourcePosition >> endColumn: anObject [

	endColumn := anObject
]

{ #category : 'accessing' }
SysmelSourcePosition >> endIndex [

	^ endIndex
]

{ #category : 'accessing' }
SysmelSourcePosition >> endIndex: anObject [

	endIndex := anObject
]

{ #category : 'accessing' }
SysmelSourcePosition >> endLine [

	^ endLine
]

{ #category : 'accessing' }
SysmelSourcePosition >> endLine: anObject [

	endLine := anObject
]

{ #category : 'as yet unclassified' }
SysmelSourcePosition >> getTextValue [
	^ sourceCode text copyFrom: startIndex to: endIndex - 1
]

{ #category : 'printing' }
SysmelSourcePosition >> printOn: aStream [
	sourceCode printOn: aStream.
	
	aStream nextPut: $:;
		print: startLine; nextPut: $.; print: startColumn;
		nextPut: $-;
		print: endLine; nextPut: $.; print: endColumn
]

{ #category : 'accessing' }
SysmelSourcePosition >> sourceCode [

	^ sourceCode
]

{ #category : 'accessing' }
SysmelSourcePosition >> sourceCode: anObject [

	sourceCode := anObject
]

{ #category : 'accessing' }
SysmelSourcePosition >> startColumn [

	^ startColumn
]

{ #category : 'accessing' }
SysmelSourcePosition >> startColumn: anObject [

	startColumn := anObject
]

{ #category : 'accessing' }
SysmelSourcePosition >> startIndex [

	^ startIndex
]

{ #category : 'accessing' }
SysmelSourcePosition >> startIndex: anObject [

	startIndex := anObject
]

{ #category : 'accessing' }
SysmelSourcePosition >> startLine [

	^ startLine
]

{ #category : 'accessing' }
SysmelSourcePosition >> startLine: anObject [

	startLine := anObject
]

{ #category : 'accessing' }
SysmelSourcePosition >> to: otherPosition [
	^ self copy
		endIndex: otherPosition endIndex;
		endLine: otherPosition endLine;
		endColumn: otherPosition endColumn;
		yourself
]

{ #category : 'accessing' }
SysmelSourcePosition >> until: otherPosition [
	^ self copy
		endIndex: otherPosition startIndex;
		endLine: otherPosition startLine;
		endColumn: otherPosition startColumn;
		yourself
]
