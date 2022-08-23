"
A SpBrickButtonBarAdapterTest is a test class for testing the behavior of SpBrickButtonBarAdapter
"
Class {
	#name : #SpBrickButtonBarAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#instVars : [
		'buttonA',
		'buttonB',
		'specWidget',
		'brickWidget'
	],
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #tests }
SpBrickButtonBarAdapterTest >> setUpSpecWidgetClass: aPresenterClass blockToSetUpSpecWidgetBeforeBuild: aBlock [

	specWidget := self newApplication new: aPresenterClass.
	aBlock value.
	specWindow := specWidget open.

	brickWidget := specWidget adapter widget.
	brickWindow := specWindow adapter widget
]

{ #category : #running }
SpBrickButtonBarAdapterTest >> specWidgetClass [

	^ SpButtonBarPresenter
]

{ #category : #tests }
SpBrickButtonBarAdapterTest >> testPlaceAtEnd [

	self
		setUpSpecWidgetClass: SpButtonBarPresenter
		blockToSetUpSpecWidgetBeforeBuild: [
			specWidget placeAtEnd.
			 
			buttonA := specWidget newButton
				           label: 'A';
				           yourself.
			buttonB := specWidget newButton
				           label: 'B';
				           yourself.
			specWidget
				add: buttonA;
				add: buttonB ].

	self assert: brickWidget children size equals: 2.
	self
		assert: brickWidget children first label asString
		equals: buttonA label asString.
	self
		assert: brickWidget children second label asString
		equals: buttonB label asString.
		
	self assert: brickWidget layout horizontalAlignment class equals: BlHorizontalEndAlignment.
]

{ #category : #tests }
SpBrickButtonBarAdapterTest >> testPlaceAtStart [

	self
		setUpSpecWidgetClass: SpButtonBarPresenter
		blockToSetUpSpecWidgetBeforeBuild: [
			specWidget placeAtStart.
			 
			buttonA := specWidget newButton
				           label: 'A';
				           yourself.
			buttonB := specWidget newButton
				           label: 'B';
				           yourself.
			specWidget
				add: buttonA;
				add: buttonB ].

	self assert: brickWidget children size equals: 2.
	self
		assert: brickWidget children first label asString
		equals: buttonA label asString.
	self
		assert: brickWidget children second label asString
		equals: buttonB label asString.
		
	self assert: brickWidget layout horizontalAlignment class equals: BlHorizontalStartAlignment.
]
