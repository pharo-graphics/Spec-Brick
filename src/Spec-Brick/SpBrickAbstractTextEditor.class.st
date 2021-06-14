Class {
	#name : #SpBrickAbstractTextEditor,
	#superclass : #BrEditor,
	#traits : 'TBrEnableable',
	#classTraits : 'TBrEnableable classTrait',
	#category : #'Spec-Brick-Text'
}

{ #category : #'api - enablement' }
SpBrickAbstractTextEditor >> disable [

	self beReadOnlyWithSelection.
	self states addState: BlElementState disabled
]

{ #category : #'api - enablement' }
SpBrickAbstractTextEditor >> enable [
	self beEditable.
	self states removeState: BlElementState disabled
]
