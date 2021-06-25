Class {
	#name : #SpBrickBoxLayoutTest,
	#superclass : #SpBrickDirectionableLayoutTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #accessing }
SpBrickBoxLayoutTest >> layoutClass [

	^ SpBoxLayout
]

{ #category : #tests }
SpBrickBoxLayoutTest >> testHorizontal [

	self testMixAddWithAddLast: self layoutClass newHorizontal.
]

{ #category : #tests }
SpBrickBoxLayoutTest >> testHorizontalPadding [

	| presenter labelPaddings |
	presenter := self newApplication new: SpPresenter.
	
	presenter layout: (SpBoxLayout newLeftToRight
		add: presenter newLabel expand: false fill: false padding: 11;
		add: presenter newLabel expand: false fill: false padding: 22;
		yourself).

	presenter buildWithSpec.
	self waitBlocSpace.
	
	labelPaddings := presenter adapter widget withAllChildrenBreadthFirst
		select: [ :each | each isKindOf: BrLabel ]
		thenCollect: [ :each | each padding ].

	presenter window ifNotNil: [ :w | w close ].
	
	self assert: labelPaddings first equals: (BlInsets horizontal: 11).
	self assert: labelPaddings second equals: (BlInsets horizontal: 22).

]

{ #category : #tests }
SpBrickBoxLayoutTest >> testMixAddWithAddLast: aSpBoxLayout [

	| presenter labelA labelB labelC labelD labelTexts |
	presenter := self newApplication new: SpPresenter.
	
	aSpBoxLayout
		add: (labelA := presenter newLabel label: 'A'; yourself);
		addLast: (labelC := presenter newLabel label: 'C'; yourself);
		add: (labelB := presenter newLabel label: 'B'; yourself);
		addLast: (labelD := presenter newLabel label: 'D'; yourself).
	
	presenter
		layout: aSpBoxLayout;
		buildWithSpec.

	labelTexts := presenter adapter widget withAllChildrenBreadthFirst
		select: [ :each | each isKindOf: BlAttributedTextElement ]
		thenCollect: [ :each | each text asString ].
	
	presenter window ifNotNil: [ :w | w close ].
		
	self assert: labelTexts equals: #(A B C D).

]

{ #category : #tests }
SpBrickBoxLayoutTest >> testVertical [

	self testMixAddWithAddLast: self layoutClass newVertical.
]

{ #category : #tests }
SpBrickBoxLayoutTest >> testVerticalPadding [

	| presenter labelPaddings |
	presenter := self newApplication new: SpPresenter.
	
	presenter layout: (SpBoxLayout newTopToBottom
		add: presenter newLabel expand: false fill: false padding: 11;
		add: presenter newLabel expand: false fill: false padding: 22;
		yourself).

	presenter buildWithSpec.

	labelPaddings := presenter adapter widget withAllChildrenBreadthFirst
		select: [ :each | each isKindOf: BrLabel ]
		thenCollect: [ :each | each padding ].
	
	presenter window close.
	
	self assert: labelPaddings first equals: (BlInsets vertical: 11).
	self assert: labelPaddings second equals: (BlInsets vertical: 22).

]
