Class {
	#name : 'SysmelTypedLambdaNode',
	#superclass : 'SysmelTypedFunctionalNode',
	#instVars : [
		'fixpointBinding',
		'exportableName'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedLambdaNode >> accept: visitor [
	^ visitor visitLambdaNode: self
]

{ #category : 'as yet unclassified' }
SysmelTypedLambdaNode >> evaluateWithArguments: arguments [
	| functionalEnvironment |
	functionalEnvironment := SysmelFunctionalActivationEnvironment parent: closureEnvironment.
	functionalEnvironment argumentValues: arguments.
	^ SysmelTypedGraphNodeEvaluator new withActivationEnvironment: functionalEnvironment
		visitNode: self body
]

{ #category : 'as yet unclassified' }
SysmelTypedLambdaNode >> findAllExportableObjects [
	^ { self }
]

{ #category : 'accessing' }
SysmelTypedLambdaNode >> fixpointBinding [

	^ fixpointBinding
]

{ #category : 'accessing' }
SysmelTypedLambdaNode >> fixpointBinding: anObject [

	fixpointBinding := anObject
]
