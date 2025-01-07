Class {
	#name : 'SysmelTypedGraphNodeEvaluator',
	#superclass : 'SysmelTypedGraphNodeVisitor',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
SysmelTypedGraphNodeEvaluator >> evaluateASG: asg [
	^ self visitNode: asg
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
