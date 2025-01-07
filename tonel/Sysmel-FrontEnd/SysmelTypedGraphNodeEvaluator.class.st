Class {
	#name : 'SysmelTypedGraphNodeEvaluator',
	#superclass : 'SysmelTypedGraphNodeVisitor',
	#instVars : [
		'environment',
		'allocaBoxCache'
	],
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'as yet unclassified' }
SysmelTypedGraphNodeEvaluator >> evaluateASG: asg [
	^ self visitNode: asg
]

{ #category : 'initialization' }
SysmelTypedGraphNodeEvaluator >> initialize [
	super initialize.
	allocaBoxCache := Dictionary new.
]

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitAllocaNode: node [
	^ allocaBoxCache at: node ifAbsentPut: (SysmelAllocaBox new
		sourcePosition: node sourcePosition;
		valueType: node valueType;
		type: node type;
		yourself)
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
SysmelTypedGraphNodeEvaluator >> visitIfNode: ifNode [
	| condition |
	condition := self visitNode: ifNode condition.
	^ condition
		ifTrue: [ self visitNode: ifNode trueResult ]
		ifFalse: [ self visitNode: ifNode falseResult ]
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
	
	(receiver isSysmelNamespace and: [arguments isEmpty]) ifTrue: [
		| child |
		child := receiver lookChildNamed: selector.
		child ifNil: [ self error: ('Failed to find namespace child named {1}' format: {selector}) atSourcePosition: node sourcePosition ].
		^ child
	].

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

{ #category : 'visiting' }
SysmelTypedGraphNodeEvaluator >> visitStoreNode: node [
	| pointer value |
	pointer := self visitNode: node pointer.
	value := self visitNode: node value.
	pointer currentValue: value.
	^ value
]

{ #category : 'as yet unclassified' }
SysmelTypedGraphNodeEvaluator >> withActivationEnvironment: activationEnvironment visitNode: body [
	environment := activationEnvironment.
	^ self visitNode: body
]
