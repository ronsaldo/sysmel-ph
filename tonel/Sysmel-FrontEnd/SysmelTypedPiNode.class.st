Class {
	#name : 'SysmelTypedPiNode',
	#superclass : 'SysmelTypedFunctionalNode',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedPiNode >> accept: visitor [
	^ visitor visitPiNode: self
]
