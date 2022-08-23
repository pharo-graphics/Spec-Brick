Class {
	#name : #SpBrickWidgetAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#instVars : [
		'specWidget',
		'brickWidget'
	],
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #testing }
SpBrickWidgetAdapterTest class >> isAbstract [

	^ self = SpBrickWidgetAdapterTest
]

{ #category : #running }
SpBrickWidgetAdapterTest >> setUp [

	super setUp.

	specWidget := self newApplication new: self specWidgetClass.
	specWindow := specWidget open.

	brickWidget := specWidget adapter widget.
	brickWindow := specWindow adapter widget
]

{ #category : #running }
SpBrickWidgetAdapterTest >> specWidgetClass [

	^ self subclassResponsibility
]

{ #category : #running }
SpBrickWidgetAdapterTest >> tearDown [

	self closeSpecWindow.

	super tearDown
]
