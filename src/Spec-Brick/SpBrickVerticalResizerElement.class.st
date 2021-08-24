Class {
	#name : #SpBrickVerticalResizerElement,
	#superclass : #SpBrickResizerElement,
	#category : #'Spec-Brick-Widgets'
}

{ #category : #initialization }
SpBrickVerticalResizerElement >> initializeHandleAndListener [

	handleElement := self newHandle.

	handleElement constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignCenter.
		c ignored vertical alignBottom.
		c horizontal exact: self handleLength.
		c vertical exact: self handleThickness ].
	
	resizerListener := BlResizerBottomListener new.
	handleElement addEventHandler: resizerListener.

]
