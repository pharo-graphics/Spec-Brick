Class {
	#name : #SpBrickTextArea,
	#superclass : #SpBrickAbstractTextEditor,
	#category : #'Spec-Brick-Text'
}

{ #category : #initialization }
SpBrickTextArea >> initialize [ 

	super initialize.

	self
		hMatchParent;
		vMatchParent

]
