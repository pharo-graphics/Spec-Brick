Class {
	#name : #SpBrickDialogElement,
	#superclass : #SpBrickWindowElement,
	#instVars : [
		'buttonBar'
	],
	#category : #'Spec-Brick-Widgets'
}

{ #category : #accessing }
SpBrickDialogElement >> buttonBar: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	self replaceChild: buttonBar with: aBlElement.
	buttonBar := aBlElement.
]

{ #category : #initialization }
SpBrickDialogElement >> initialize [

	super initialize.

	buttonBar := self newEmptyElement.

	self addChild: buttonBar as: #buttonBar
]

{ #category : #accessing }
SpBrickDialogElement >> removeButtonBar [
	
	self buttonBar: self newEmptyElement	
]
