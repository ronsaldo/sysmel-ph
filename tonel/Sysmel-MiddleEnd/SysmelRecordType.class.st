Class {
	#name : 'SysmelRecordType',
	#superclass : 'SysmelProductType',
	#instVars : [
		'fieldNames'
	],
	#category : 'Sysmel-MiddleEnd-TypeSystem',
	#package : 'Sysmel-MiddleEnd',
	#tag : 'TypeSystem'
}

{ #category : 'accessing' }
SysmelRecordType >> fieldNames [

	^ fieldNames
]

{ #category : 'accessing' }
SysmelRecordType >> fieldNames: anObject [

	fieldNames := anObject
]
