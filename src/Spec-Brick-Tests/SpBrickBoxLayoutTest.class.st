Class {
	#name : #SpBrickBoxLayoutTest,
	#superclass : #SpBrickAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #tests }
SpBrickBoxLayoutTest >> testTopToBottom [

	| presenter labelA labelB |
	presenter := self newApplication new: SpPresenter.
	
	presenter layout: (SpBoxLayout newTopToBottom
		add: (labelA := presenter newLabel label: 'A'; yourself);
		add: (labelB := presenter newLabel label: 'B'; yourself);
		yourself).

	presenter openWithSpec.
	
	1halt.

]
