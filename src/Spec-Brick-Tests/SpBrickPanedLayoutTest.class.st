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
SpBrickPanedLayoutTest >> testHorizontal [

	| aSpDirectionableLayout presenter labelA labelB elements |
	presenter := self newApplication new: SpPresenter.
	
	aSpDirectionableLayout := self layoutClass newHorizontal
		add: (labelA := presenter newLabel);
		add: (labelB := presenter newLabel);
		yourself.

	presenter
		layout: aSpDirectionableLayout;
		buildWithSpec.

	elements := presenter adapter widget children.
	self
		assert: elements first
		equals: labelA adapter widget.
	self
		assert: elements third
		equals: labelB adapter widget.
	self
		assert: elements second class
		equals: SpBrickHorizontalResizerElement.

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

{ #category : #tests }
SpBrickPanedLayoutTest >> testVertical [

	| aSpDirectionableLayout presenter labelA labelB elements |
	presenter := self newApplication new: SpPresenter.
	
	aSpDirectionableLayout := self layoutClass newVertical
		add: (labelA := presenter newLabel);
		add: (labelB := presenter newLabel);
		yourself.

	presenter
		layout: aSpDirectionableLayout;
		buildWithSpec.

	elements := presenter adapter widget children.
	self
		assert: elements first
		equals: labelA adapter widget.
	self
		assert: elements third
		equals: labelB adapter widget.
	self
		assert: elements second class
		equals: SpBrickVerticalResizerElement.

]
