Class {
	#name : #SpBrickTextInputFieldAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #tests }
SpBrickTextInputFieldAdapterTest >> specWidgetClass [

	^ SpTextInputFieldPresenter
]

{ #category : #tests }
SpBrickTextInputFieldAdapterTest >> testText [

	specWidget text: 'Hello Brick'.
	self assert: specWidget text asString equals: 'Hello Brick'.
	
	brickWidget text: 'Hello Spec' asRopedText.
	self assert: specWidget text asString equals: 'Hello Spec'.

]
