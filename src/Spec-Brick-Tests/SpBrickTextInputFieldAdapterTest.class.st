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

	specWidget enabled: true.
	self assert: brickWidget isEnabled.

	specWidget enabled: false.
	self deny: brickWidget isEnabled.

	specWidget enabled: true.
	self assert: brickWidget isEnabled.

]

{ #category : #tests }
SpBrickTextInputFieldAdapterTest >> testText [

	"Initial text"
	self assert: brickWidget text asString equals: specWidget text.

	"spec -> brick"
	specWidget text: 'Hello Brick'.
	self waitUI.
	self assert: brickWidget text asString equals: 'Hello Brick'.
	
	"brick -> spec"
	brickWidget text: 'Hello Spec' asRopedText.
	self assert: specWidget text equals: 'Hello Spec'.

]
