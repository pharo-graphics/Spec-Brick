Class {
	#name : #SpBrickBoxLayoutTest,
	#superclass : #SpBrickAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #tests }
SpBrickBoxLayoutTest >> testLeftToRight [

	| presenter labelA labelB labelC labelD labelTexts |
	presenter := self newApplication new: SpPresenter.
	
	presenter layout: (SpBoxLayout newLeftToRight
		add: (labelA := presenter newLabel label: 'A'; yourself);
		addLast: (labelC := presenter newLabel label: 'C'; yourself);
		add: (labelB := presenter newLabel label: 'B'; yourself);
		addLast: (labelD := presenter newLabel label: 'D'; yourself);
		yourself).

	presenter buildWithSpec.

	labelTexts := presenter adapter widget withAllChildrenBreadthFirst
		select: [ :each | each isKindOf: BlAttributedTextElement ]
		thenCollect: [ :each | each text asString ].
		
	self assert: labelTexts equals: #(A B C D).

]

{ #category : #tests }
SpBrickBoxLayoutTest >> testLeftToRightWithPadding [

	| presenter labelPaddings |
	presenter := self newApplication new: SpPresenter.
	
	presenter layout: (SpBoxLayout newLeftToRight
		add: presenter newLabel expand: false fill: false padding: 11;
		add: presenter newLabel expand: false fill: false padding: 22;
		yourself).

	presenter buildWithSpec.

	labelPaddings := presenter adapter widget withAllChildrenBreadthFirst
		select: [ :each | each isKindOf: BrLabel ]
		thenCollect: [ :each | each padding ].
	
	self assert: labelPaddings first equals: (BlInsets horizontal: 11).
	self assert: labelPaddings second equals: (BlInsets horizontal: 22).

]

{ #category : #tests }
SpBrickBoxLayoutTest >> testTopToBottom [

	| presenter labelA labelB labelC labelD labelTexts |
	presenter := self newApplication new: SpPresenter.
	
	presenter layout: (SpBoxLayout newTopToBottom
		add: (labelA := presenter newLabel label: 'A'; yourself);
		addLast: (labelC := presenter newLabel label: 'C'; yourself);
		add: (labelB := presenter newLabel label: 'B'; yourself);
		addLast: (labelD := presenter newLabel label: 'D'; yourself);
		yourself).

	presenter buildWithSpec.

	labelTexts := presenter adapter widget withAllChildrenBreadthFirst
		select: [ :each | each isKindOf: BlAttributedTextElement ]
		thenCollect: [ :each | each text asString ].
		
	self assert: labelTexts equals: #(A B C D).

]

{ #category : #tests }
SpBrickBoxLayoutTest >> testTopToBottomWithPadding [

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
	
	self assert: labelPaddings first equals: (BlInsets vertical: 11).
	self assert: labelPaddings second equals: (BlInsets vertical: 22).

]
