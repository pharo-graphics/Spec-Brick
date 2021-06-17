Class {
	#name : #SpBrickTextArea,
	#superclass : #SpBrickAbstractTextEditor,
	#category : #'Spec-Brick-Widgets-Text'
}

{ #category : #initialization }
SpBrickTextArea >> initialize [ 

	super initialize.

	self
		hMatchParent;
		vMatchParent

]
