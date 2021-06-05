Class {
	#name : #SpBrickTextInputFieldAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #tests }
SpBrickTextInputFieldAdapterTest >> specWidgetClass [

	^ SpTextInputFieldPresenter
]

{ #category : #tests }
SpBrickTextInputFieldAdapterTest >> testEnabled [

	"Initial value"
	self assert: specWidget isEnabled equals: brickWidget isEnabled.

	"Probably redundant"
	specWidget enabled: true.
	self assert: brickWidget isEnabled.

	"Change value"
	specWidget enabled: false.
	self deny: brickWidget isEnabled.

	"Change value back"
	specWidget enabled: true.
	self assert: brickWidget isEnabled.

]

{ #category : #tests }
SpBrickTextInputFieldAdapterTest >> testText [

	"Initial text"
	self assert: brickWidget text asString equals: specWidget text.

	"spec -> brick"
	specWidget text: 'Brick'.
	self waitUI.
	self assert: brickWidget text asString equals: 'Brick'.
	
	"brick -> spec"
	brickWidget inUIProcessDo:[ brickWidget text: 'Spec' asRopedText ].
	self waitUI.
	self assert: specWidget text asString equals: 'Spec'.

]
