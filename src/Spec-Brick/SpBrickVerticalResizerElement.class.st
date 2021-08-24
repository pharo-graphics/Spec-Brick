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
		c horizontal exact: 25.
		c vertical exact: 5 ].
	
	resizerListener := BlResizerBottomListener new.
	handleElement addEventHandler: resizerListener.

]
