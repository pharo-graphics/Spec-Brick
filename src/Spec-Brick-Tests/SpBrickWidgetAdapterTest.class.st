Class {
	#name : #SpBrickWidgetAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#instVars : [
		'brickWidget',
		'specWidget',
		'brickWindow'
	],
	#category : #'Spec-Brick-Tests'
}

{ #category : #running }
SpBrickWidgetAdapterTest >> setUp [

	super setUp.

	specWindow := self newApplication new: SpWindowPresenter.
	specWidget := specWindow instantiate: self specWidgetClass.
	specWindow presenter: specWidget.
	specWindow buildWithSpecLayout: self specWidgetClass defaultSpec.
	
	brickWidget := specWidget adapter widget.
	brickWindow := specWindow adapter widget.
]

{ #category : #running }
SpBrickWidgetAdapterTest >> specWidgetClass [

	^ self subclassResponsibility
]

{ #category : #running }
SpBrickWidgetAdapterTest >> tearDown [

	self ensureCloseWindowPresenter.

	super tearDown
]
