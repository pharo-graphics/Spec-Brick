Class {
	#name : #SpBrickAbstractTextAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #testing }
SpBrickAbstractTextAdapterTest class >> isAbstract [

	^ self = SpBrickAbstractTextAdapterTest
]

{ #category : #tests }
SpBrickAbstractTextAdapterTest >> testEnabled [

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
SpBrickAbstractTextAdapterTest >> testText [

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
