Extension { #name : 'Object' }

{ #category : '*Sysmel-FrontEnd' }
Object >> asSysmelType [
	^ self class
]

{ #category : '*Sysmel-FrontEnd' }
Object >> computeResultTypeWithAnalyzedArguments: analyzedArguments [
	^ SysmelTypeGradual uniqueInstance

]

{ #category : '*Sysmel-FrontEnd' }
Object >> defaultValue [
	^ nil
]

{ #category : '*Sysmel-FrontEnd' }
Object >> isGradualType [
	^ false
]

{ #category : '*Sysmel-FrontEnd' }
Object >> isReferenceLikeType [
	^ false
]

{ #category : '*Sysmel-FrontEnd' }
Object >> isValidSysmelType [
	^ false
]

{ #category : '*Sysmel-FrontEnd' }
Object >> isVoidType [
	^ false
]
