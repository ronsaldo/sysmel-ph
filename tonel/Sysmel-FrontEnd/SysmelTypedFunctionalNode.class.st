Class {
	#name : 'SysmelTypedFunctionalNode',
	#superclass : 'SysmelTypedGraphNode',
	#instVars : [
		'name',
		'arguments',
		'isVariadic',
		'captureBindings',
		'body',
		'callingConvention',
		'closureEnvironment'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'testing' }
SysmelTypedFunctionalNode class >> isAbstract [
	^ self == SysmelTypedFunctionalNode
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> arguments [

	^ arguments
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> body [

	^ body
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> callingConvention [

	^ callingConvention
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> callingConvention: anObject [

	callingConvention := anObject
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> captureBindings [

	^ captureBindings
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> captureBindings: anObject [

	captureBindings := anObject
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> closureEnvironment [

	^ closureEnvironment
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> closureEnvironment: anObject [

	closureEnvironment := anObject
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> exportableName [
	^ name
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> isVariadic [

	^ isVariadic
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> isVariadic: anObject [

	isVariadic := anObject
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> name [

	^ name
]

{ #category : 'accessing' }
SysmelTypedFunctionalNode >> name: anObject [

	name := anObject
]
