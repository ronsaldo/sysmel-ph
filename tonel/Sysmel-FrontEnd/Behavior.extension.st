Extension { #name : 'Behavior' }

{ #category : '*Sysmel-FrontEnd' }
Behavior >> isSubtypeOf: targetType [
	| currentPosition |
	currentPosition := self.
	[ currentPosition isNotNil ] whileTrue: [ 
		currentPosition = targetType ifTrue: [ ^ true ].
		currentPosition := superclass
	].
	^ false
]

{ #category : '*Sysmel-FrontEnd' }
Behavior >> isValidSysmelType [
	^ true
]
