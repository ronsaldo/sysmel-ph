Class {
	#name : 'SysmelTypedSigmaNode',
	#superclass : 'SysmelTypedFunctionalNode',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedSigmaNode >> accept: visitor [
	^ visitor visitSigmaNode: self
]
