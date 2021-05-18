Class {
	#name : #BaselineOfSpecBrickDraft,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpecBrick
}

{ #category : #baseline }
BaselineOfSpecBrickDraft >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			self
				declareBrickOn: spec.

			spec
				package: 'Spec-Brick' with: [ spec requires: #('Brick') ];
				package: 'Spec-Brick-Tests'.
 ]
]

{ #category : #'external projects' }
BaselineOfSpecBrickDraft >> declareBrickOn: spec [
	spec
		baseline: 'Brick'
		with: [ spec repository: 'github://StevenCostiou/Brick:COMMITISH/src' ]
]
