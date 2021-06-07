Class {
	#name : #BaselineOfSpecBrick,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpecBrick
}

{ #category : #baseline }
BaselineOfSpecBrick >> baseline: spec [
	<baseline>
	
	spec
		for: #common
		do: [ 
			self declareBrickOn: spec.

			spec
				package: 'Spec-Brick' with: [ spec requires: #('NewBrick') ];
				package: 'Spec-Brick-Tests' with: [ spec requires: #('Spec-Brick') ];
				package: 'Spec-Brick-Examples-ToDoList' with: [ spec requires: #('Spec-Brick') ].
"				package: 'Spec-Brick-MockedHost' with: [ spec requires: #('Spec-Brick') ]; --> Loading this package is buggy since it overrides the regular adapter. See SpBrickOnMockedHostAdapterBindings>>#allAdapters"
		]
]

{ #category : #'external projects' }
BaselineOfSpecBrick >> declareBrickOn: spec [
	spec
		baseline: 'NewBrick'
		with: [ spec repository: 'github://pharo-graphics/Brick:master/src' ]
]
