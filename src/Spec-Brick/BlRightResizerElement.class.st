Class {
	#name : #BlRightResizerElement,
	#superclass : #BlOverlayElement,
	#instVars : [
		'handleElement',
		'resizerListener'
	],
	#category : #'Spec-Brick-Widgets'
}

{ #category : #'api - attaching / detaching' }
BlRightResizerElement >> attachTo: anElement [
	super attachTo: anElement.

	resizerListener resizeTarget: anElement
]

{ #category : #'api - accessing handles' }
BlRightResizerElement >> handleElement [
	<return: #BlElement>

	^ handleElement
]

{ #category : #initialization }
BlRightResizerElement >> initialize [

	super initialize.
	
"	self border: (BlBorder paint: (Color blue alpha: 0.1) width: 5)."

	
	handleElement := self newHandle.
	handleElement constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight.
"		c ignored vertical alignCenter"
		c horizontal exact: 5.
		c vertical matchParent ].
	
	resizerListener := BlResizerRightListener new.
	handleElement addEventHandler: resizerListener.
	
	self addChild: handleElement
]

{ #category : #'instance creation' }
BlRightResizerElement >> newHandle [
	^ BlElement new
		opacity: 0.5;
		background: (Color white);
		border: (BlBorder paint: Color gray width: 1);
		yourself
		"size: 16@16"
]
