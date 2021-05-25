Class {
	#name : #SpBrickLabelAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #tests }
SpBrickLabelAdapterTest >> specWidgetClass [

	^ SpLabelPresenter
]

{ #category : #tests }
SpBrickLabelAdapterTest >> testLabel [

	specWidget label: 'Hello Brick'.
	
	self assert: brickWidget text asString equals: 'Hello Brick'
]
