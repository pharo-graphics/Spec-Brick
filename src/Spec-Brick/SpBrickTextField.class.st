Class {
	#name : #SpBrickTextField,
	#superclass : #SpBrickAbstractTextEditor,
	#category : #'Spec-Brick-Widgets-Text'
}

{ #category : #initialization }
SpBrickTextField >> initialize [ 

	super initialize.

	self
		hMatchParent;
		vFitContent;
		inputFilter: SpBrickOneLineInputFilter new

]
