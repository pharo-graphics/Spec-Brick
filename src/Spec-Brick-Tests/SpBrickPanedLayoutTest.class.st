Class {
	#name : #SpBrickPanedLayoutTest,
	#superclass : #SpBrickDirectionableLayoutTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #accessing }
SpBrickPanedLayoutTest >> layoutClass [

	^ SpPanedLayout
]

{ #category : #tests }
SpBrickPanedLayoutTest >> testPositionOfSlider [

	| aSpDirectionableLayout presenter labelA labelB |
	presenter := self newApplication new: SpPresenter.
	
	aSpDirectionableLayout := self layoutClass newHorizontal
		positionOfSlider: 0.75;
		add: (labelA := presenter newLabel);
		add: (labelB := presenter newLabel);
		yourself.

	presenter
		layout: aSpDirectionableLayout;
		buildWithSpec.

	self
		assert: labelA adapter widget constraints linear weight
		equals: 0.75.
	self
		assert: labelB adapter widget constraints linear weight
		equals: 0.25.

]
