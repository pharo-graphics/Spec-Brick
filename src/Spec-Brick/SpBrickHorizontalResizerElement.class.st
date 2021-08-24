Class {
	#name : #SpBrickHorizontalResizerElement,
	#superclass : #SpBrickResizerElement,
	#category : #'Spec-Brick-Widgets'
}

{ #category : #initialization }
SpBrickHorizontalResizerElement >> initializeHandleAndListener [

	handleElement := self newHandle.

	handleElement constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight.
		c ignored vertical alignCenter.
		c horizontal exact: self handleThickness.
		c vertical exact: self handleLength ].
	
	resizerListener := BlResizerRightListener new.
	handleElement addEventHandler: resizerListener.

]
