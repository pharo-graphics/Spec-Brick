Class {
	#name : #SpBrickTextField,
	#superclass : #BrEditor,
	#traits : 'TBrEnableable',
	#classTraits : 'TBrEnableable classTrait',
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
