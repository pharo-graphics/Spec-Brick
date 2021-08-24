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
		c horizontal exact: 5.
		c vertical exact: 25 ].
	
	resizerListener := BlResizerRightListener new.
	handleElement addEventHandler: resizerListener.

]
