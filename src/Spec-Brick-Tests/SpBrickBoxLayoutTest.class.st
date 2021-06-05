Class {
	#name : #SpBrickBoxLayoutTest,
	#superclass : #SpBrickAdapterTest,
	#category : #'Spec-Brick-Tests'
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
