Class {
	#name : 'SysmelTypedGraphNodeEvaluator',
	#superclass : 'SysmelTypedGraphNodeVisitor',
	#instVars : [
		'environment'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
SysmelTypedGraphNodeEvaluator >> evaluateASG: asg [
	^ self visitNode: asg
]

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitApplicationNode: node [
	| functional arguments |
	functional := self visitNode: node functional.
	arguments := node arguments collect: [ :arg | self visitNode: arg ].
	^ functional evaluateWithArguments: arguments
]

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitArgumentNode: node [
	| argumentIndex |
	argumentIndex := node binding index.
	^ environment getIndexedArgumentValue: argumentIndex
]

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitLambdaNode: aLambdaNode [
	^ aLambdaNode
]

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitLiteralNode: node [
	^ node value
]

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitMessageSendNode: node [
	| receiver selector arguments |
	receiver := self visitNode: node receiver.
	selector := node selector.
	arguments := node arguments collect: [ :eachArg | self visitNode: eachArg ].
	^ receiver perform: selector withArguments: arguments
]

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitSequenceNode: node [
	| result |
	result := nil.
	node expressions do: [ :eachExpression |
		result := self visitNode: eachExpression
	].
	^ result
]

{ #category : 'as yet unclassified' }
SysmelTypedGraphNodeEvaluator >> withActivationEnvironment: activationEnvironment visitNode: body [
	environment := activationEnvironment.
	^ self visitNode: body
]
