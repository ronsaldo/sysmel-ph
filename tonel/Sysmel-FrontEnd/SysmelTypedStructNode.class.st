Class {
	#name : 'SysmelTypedStructNode',
	#superclass : 'SysmelTypedTupleLikeNode',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedStructNode >> accept: visitor [
	^ visitor visitStructNode: self
]

{ #category : 'testing' }
SysmelTypedStructNode >> hasDictionaryAsInput: hasDictionaryConstruction [
	| dictionary |
	hasDictionaryConstruction ifFalse: [ ^ self ].
	self assert: elements first isDictionaryNode.
	dictionary := elements first.
	elements := type elements collect: [ :eachElement | eachElement defaultValue ].
	dictionary elements do: [ :eachAssociation |
		| fieldName fieldValue fieldIndex |
		fieldName := eachAssociation key value.
		fieldValue := eachAssociation value.
		fieldIndex := type nameToIndex: fieldName.
		fieldIndex ifNil: [
			self error: ('Failed to find index for field {1} in {2}.' format: { fieldName. type printString }) 
		].
		
		elements at: fieldIndex put: fieldValue
	].
]
