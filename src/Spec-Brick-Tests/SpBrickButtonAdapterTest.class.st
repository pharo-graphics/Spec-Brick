Class {
	#name : #SpBrickButtonAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #tests }
SpBrickButtonAdapterTest >> specWidgetClass [

	^ SpButtonPresenter
]

{ #category : #tests }
SpBrickButtonAdapterTest >> testAction [

	| evaluated |
	evaluated := false.
	specWidget action: [ evaluated := true ].

	"Simulate button clicked"
	brickWidget action value.
	self assert: evaluated.
]

{ #category : #tests }
SpBrickButtonAdapterTest >> testEnabled [

	specWidget enabled: true.
	self assert: brickWidget isEnabled.

	specWidget enabled: false.
	self deny: brickWidget isEnabled.

]

{ #category : #tests }
SpBrickButtonAdapterTest >> testIcon [

	| aForm |
	aForm := self iconNamed: #remove.
	self deny: aForm isNil.

	specWidget icon: aForm.

	self assert: brickWidget icon equals: aForm.
]

{ #category : #tests }
SpBrickButtonAdapterTest >> testLabel [

	specWidget label: 'Hello Brick'.
	
	self assert: brickWidget label asString equals: 'Hello Brick'.
	self assert: brickWidget icon equals: specWidget adapter nullIcon
]
