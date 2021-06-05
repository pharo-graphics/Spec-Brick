Class {
	#name : #SpBrickTextField,
	#superclass : #BrEditor,
	#traits : 'TBrEnableable',
	#classTraits : 'TBrEnableable classTrait',
	#category : #'Spec-Brick-Text'
}

{ #category : #'api - enablement' }
SpBrickTextField >> disable [

	self beReadOnlyWithSelection.
	self states addState: BlElementState disabled
]

{ #category : #'api - enablement' }
SpBrickTextField >> enable [
	self beEditable.
	self states removeState: BlElementState disabled
]

{ #category : #initialization }
SpBrickTextField >> initialize [ 

	super initialize.

	self
		hMatchParent;
		vFitContent;
		inputFilter: SpBrickOneLineInputFilter new

]
