Class {
	#name : 'SysmelParseTreeFunctionalDependentTypeNode',
	#superclass : 'SysmelParseTreeNode',
	#instVars : [
		'argumentPattern',
		'resultType',
		'callingConvention'
	],
	#category : 'Sysmel-FrontEnd-Parser',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Parser'
}

{ #category : 'visiting' }
SysmelParseTreeFunctionalDependentTypeNode >> accept: visitor [
	^ visitor visitFunctionalDependentNode: self
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> argumentPattern [

	^ argumentPattern
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> argumentPattern: anObject [

	argumentPattern := anObject
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> callingConvention [

	^ callingConvention
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> callingConvention: anObject [

	callingConvention := anObject
]

{ #category : 'as yet unclassified' }
SysmelParseTreeFunctionalDependentTypeNode >> constructLambdaWithName: nameExpression body: body isFixpoint: isFixpoint [
	| bodyOrInnerLambda argumentNodes isExistential isVariadic argumentUnpackedData |
	bodyOrInnerLambda := body.
	resultType isFunctionalDependentTypeNode ifTrue: [
		bodyOrInnerLambda := resultType constructLambdaWithName: nil body: body isFixpoint: false 
	].

	argumentNodes := #().
	isExistential := false.
	isVariadic := false.
	
	argumentPattern ifNotNil: [
		argumentUnpackedData := argumentPattern parseAndUnpackArgumentsPattern.
		argumentNodes := argumentUnpackedData first.
		isExistential := argumentUnpackedData second.
		isVariadic := argumentUnpackedData third.
	].
	
	^ SysmelParseTreeLambdaNode new
		sourcePosition: self sourcePosition;
		nameExpression: nameExpression;
		arguments: argumentNodes;
		isVariadic: isVariadic;
		resultType: resultType;
		body: bodyOrInnerLambda;
		callingConvention: callingConvention;
		isFixpoint: isFixpoint;
		yourself
]

{ #category : 'testing' }
SysmelParseTreeFunctionalDependentTypeNode >> isFunctionalDependentTypeNode [
	^ true
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> resultType [

	^ resultType
]

{ #category : 'accessing' }
SysmelParseTreeFunctionalDependentTypeNode >> resultType: anObject [

	resultType := anObject
]
