"
A SpBrickListAdapterTest is a test class for testing the behavior of SpBrickListAdapter
"
Class {
	#name : #SpBrickListAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #running }
SpBrickListAdapterTest >> specWidgetClass [

	^ SpListPresenter
]

{ #category : #tests }
SpBrickListAdapterTest >> testItems [

	| someItems |
	someItems := $a to: $g.
	specWidget items: someItems.
	self assert: brickWidget items equals: someItems.

]

{ #category : #tests }
SpBrickListAdapterTest >> testSelectItem [

	| someItems |
	someItems := $a to: $g.
	specWidget items: someItems.

	specWidget selectItem: $c.
	self assert: brickWidget selectedIndices equals: #(3).

]

{ #category : #tests }
SpBrickListAdapterTest >> testSelectionIsResetedAfterItemsAreSet [

	| someItems |
	someItems := $a to: $g.
	specWidget
		items: someItems;
		selectItem: $c;
		items: (someItems copyWith: $z).
	self assert: brickWidget selectedIndices isEmpty.

]

{ #category : #tests }
SpBrickListAdapterTest >> testUnselectAll [

	| someItems |
	someItems := $a to: $g.
	specWidget items: someItems.

	specWidget selectItem: $c.
	specWidget unselectAll.
	self assert: brickWidget selectedIndices isEmpty.

]

{ #category : #tests }
SpBrickListAdapterTest >> testWhenSelectionChangedDo [

	| someItems evaluated |
	someItems := $a to: $g.
	specWidget items: someItems.

	evaluated := false.
	specWidget whenSelectionChangedDo: [ evaluated := true ].

	"Simulate c is clicked"
	brickWidget selectOne: 3.

	self assert: evaluated.
	self assert: specWidget selectedItem equals: $c.

]
