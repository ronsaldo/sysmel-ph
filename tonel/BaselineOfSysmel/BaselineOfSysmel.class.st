Class {
	#name : 'BaselineOfSysmel',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSysmel',
	#package : 'BaselineOfSysmel'
}

{ #category : 'baselines' }
BaselineOfSysmel >> baseline: spec [
    <baseline>
	spec for: #'common' do: [
		spec
			package: #'Sysmel-Backend';
			package: #'Sysmel-Backend-Tests' with: [
				spec requires: #( #'Sysmel-Backend' ).
			];
			package: #'Sysmel-MiddleEnd' with: [
				spec requires: #( #'Sysmel-Backend' ).
			];
			package: #'Sysmel-MiddleEnd-Tests' with: [
				spec requires: #( #'Sysmel-MiddleEnd' ).
			];
			package: #'Sysmel-FrontEnd' with: [
				spec requires: #( #'Sysmel-MiddleEnd' ).
			];
			package: #'Sysmel-FrontEnd-Tests' with: [
				spec requires: #( #'Sysmel-FrontEnd' ).
			]
	].
]
