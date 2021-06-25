Class {
	#name : #SpBrickDirectionableLayoutTest,
	#superclass : #SpBrickAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #testing }
SpBrickDirectionableLayoutTest class >> isAbstract [

	^ self = SpBrickDirectionableLayoutTest
]

{ #category : #tests }
SpBrickDirectionableLayoutTest >> layoutClass [

	^ self subclassResponsibility
]

{ #category : #tests }
SpBrickDirectionableLayoutTest >> testAddTwoLabelsInCorrectOrderWith: aSpDirectionableLayout [

	| presenter labelA labelB labelTexts |
	[
		presenter := self newApplication new: SpPresenter.
		
		aSpDirectionableLayout
			add: (labelA := presenter newLabel label: 'A'; yourself);
			add: (labelB := presenter newLabel label: 'B'; yourself).

		presenter
			layout: aSpDirectionableLayout;
			buildWithSpec.

		labelTexts := presenter adapter widget withAllChildrenBreadthFirst
			select: [ :each | each isKindOf: BlAttributedTextElement ]
			thenCollect: [ :each | each text asString ].
			
		self assert: labelTexts equals: #(A B)
	
	] ensure: [ 
		presenter window ifNotNil: [ :w | w close ] ]



]

{ #category : #tests }
SpBrickDirectionableLayoutTest >> testNewHorizontal [

	self testAddTwoLabelsInCorrectOrderWith: self layoutClass newHorizontal
]

{ #category : #tests }
SpBrickDirectionableLayoutTest >> testNewLeftToRight [

	self testAddTwoLabelsInCorrectOrderWith: self layoutClass newLeftToRight
]

{ #category : #tests }
SpBrickDirectionableLayoutTest >> testNewTopToBottom [

	self testAddTwoLabelsInCorrectOrderWith: self layoutClass newTopToBottom
]

{ #category : #tests }
SpBrickDirectionableLayoutTest >> testNewVertical [

	self testAddTwoLabelsInCorrectOrderWith: self layoutClass newVertical
]
