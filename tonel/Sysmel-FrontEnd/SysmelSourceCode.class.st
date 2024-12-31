"
I encapsulate a specific piece of source code.
"
Class {
	#name : 'SysmelSourceCode',
	#superclass : 'Object',
	#instVars : [
		'directory',
		'name',
		'language',
		'text'
	],
	#pools : [
		'SysmelScannerTokens'
	],
	#category : 'Sysmel-FrontEnd-Scanner',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Scanner'
}

{ #category : 'construction' }
SysmelSourceCode class >> forSysmelText: aString [
	^ self new
		directory: '';
		name: '<workspace>';
		language: #sysmel;
		text: aString;
		yourself
]

{ #category : 'accessing' }
SysmelSourceCode >> directory [

	^ directory
]

{ #category : 'accessing' }
SysmelSourceCode >> directory: anObject [

	directory := anObject
]

{ #category : 'accessing' }
SysmelSourceCode >> language [

	^ language
]

{ #category : 'accessing' }
SysmelSourceCode >> language: anObject [

	language := anObject
]

{ #category : 'accessing' }
SysmelSourceCode >> name [

	^ name
]

{ #category : 'accessing' }
SysmelSourceCode >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
SysmelSourceCode >> text [

	^ text
]

{ #category : 'accessing' }
SysmelSourceCode >> text: anObject [

	text := anObject
]
