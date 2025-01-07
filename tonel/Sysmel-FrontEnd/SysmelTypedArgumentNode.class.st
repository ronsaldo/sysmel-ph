Class {
	#name : 'SysmelTypedArgumentNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'binding',
		'isImplicit',
		'isExistential'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedArgumentNode >> accept: visitor [
	^ visitor visitArgumentNode: self
]

{ #category : 'accessing' }
SysmelTypedArgumentNode >> binding [

	^ binding
]

{ #category : 'accessing' }
SysmelTypedArgumentNode >> binding: anObject [

	binding := anObject
]

{ #category : 'accessing' }
SysmelTypedArgumentNode >> isExistential [

	^ isExistential
]

{ #category : 'accessing' }
SysmelTypedArgumentNode >> isExistential: anObject [

	isExistential := anObject
]

{ #category : 'accessing' }
SysmelTypedArgumentNode >> isImplicit [

	^ isImplicit
]

{ #category : 'accessing' }
SysmelTypedArgumentNode >> isImplicit: anObject [

	isImplicit := anObject
]
