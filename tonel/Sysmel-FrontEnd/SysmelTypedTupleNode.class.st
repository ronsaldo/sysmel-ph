Class {
	#name : 'SysmelTypedTupleNode',
	#superclass : 'SysmelTypedTupleLikeNode',
	#category : 'Sysmel-FrontEnd-Analysis',
	#package : 'Sysmel-FrontEnd',
	#tag : 'Analysis'
}

{ #category : 'visiting' }
SysmelTypedTupleNode >> accept: visitor [
	^ visitor visitTupleNode: self
]
