Class {
	#name : #SpBrickTextField,
	#superclass : #SpBrickAbstractTextEditor,
	#category : #'Spec-Brick-Text'
}

{ #category : #initialization }
SpBrickTextField >> initialize [ 

	super initialize.

	self
		hMatchParent;
		vFitContent;
		inputFilter: SpBrickOneLineInputFilter new

]
