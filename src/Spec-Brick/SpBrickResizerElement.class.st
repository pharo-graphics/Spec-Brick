Class {
	#name : #SpBrickResizerElement,
	#superclass : #BlOverlayElement,
	#instVars : [
		'handleElement',
		'resizerListener'
	],
	#category : #'Spec-Brick-Widgets'
}

{ #category : #'api - attaching / detaching' }
SpBrickResizerElement >> attachTo: anElement [
	super attachTo: anElement.

	resizerListener resizeTarget: anElement
]

{ #category : #'api - accessing handles' }
SpBrickResizerElement >> handleElement [

	^ handleElement
]

{ #category : #initialization }
SpBrickResizerElement >> initialize [

	super initialize.
	self initializeHandleAndListener.
	
	self addChild: handleElement
]

{ #category : #initialization }
SpBrickResizerElement >> initializeHandleAndListener [

	self subclassResponsibility
]

{ #category : #'instance creation' }
SpBrickResizerElement >> newHandle [

	^ BlElement new
		opacity: 0.5;
		background: BrGlamorousColors successBackgroundColor;
"		border: (BlBorder paint: BrGlamorousColors defaultHeaderTextColor width: 1);"
		yourself

]
