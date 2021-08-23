"
A SpBrickListAdapterTest is a test class for testing the behavior of SpBrickListAdapter
"
Class {
	#name : #SpBrickListLikeAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #tests }
SpBrickListLikeAdapterTest >> testItems [

	| someItems |
	someItems := $a to: $g.
	specWidget items: someItems.
	self assert: brickWidget items equals: someItems.

]

{ #category : #tests }
SpBrickListLikeAdapterTest >> testSelectItem [

	| someItems |
	someItems := $a to: $g.
	specWidget items: someItems.

	specWidget selectItem: $c.
	self assert: brickWidget selectedIndices equals: #(3).

]

{ #category : #tests }
SpBrickListLikeAdapterTest >> testSelectionIsResetedAfterItemsAreSet [

	| someItems |
	someItems := $a to: $g.
	specWidget
		items: someItems;
		selectItem: $c;
		items: (someItems copyWith: $z).
	self assert: brickWidget selectedIndices isEmpty.

]

{ #category : #tests }
SpBrickListLikeAdapterTest >> testUnselectAll [

	| someItems |
	someItems := $a to: $g.
	specWidget items: someItems.

	specWidget selectItem: $c.
	specWidget unselectAll.
	self assert: brickWidget selectedIndices isEmpty.

]

{ #category : #tests }
SpBrickListLikeAdapterTest >> testWhenActivatedDo [

	| someItems evaluated |
	someItems := $a to: $g.
	specWidget items: someItems.

	evaluated := false.
	specWidget whenActivatedDo: [ evaluated := true ].

	"Simulate c is double-clicked"
	brickWidget dispatchEvent: (BrSelectionDoubleClicked new selection: #(3); yourself).

	self assert: evaluated.
	self assert: specWidget selectedItem equals: $c.

]

{ #category : #tests }
SpBrickListLikeAdapterTest >> testWhenSelectionChangedDo [

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
