Class {
	#name : #SpBrickListLikeAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #accessing }
SpBrickListLikeAdapter >> elementAt: anInteger [

	^ widget viewModel itemAt: anInteger
]

{ #category : #'widget update' }
SpBrickListLikeAdapter >> newContextMenuAptitude [

	^ BrGlamorousWithContextMenuAptitude content: [ 
		  self presenter contextMenu value buildWithSpec ]
]

{ #category : #'widget update' }
SpBrickListLikeAdapter >> presenterUpdateSelection: aBrSelectionChanged [ 
	"Inform the presenter with the new selection"
	
	self presenter selection selectIndexes: aBrSelectionChanged indices
]

{ #category : #'widget update' }
SpBrickListLikeAdapter >> refreshList [

	widget invalidate
]

{ #category : #'widget update' }
SpBrickListLikeAdapter >> refreshWidgetSelection [
	"Act after a change in the presenter's selection. This could be a change in:
	- the selection mode (simple, multiple)
	- the selected item(s)
	- initialization on build process
	"

	| indices |
	indices := self presenter selection selectedIndexes.

	self flag: #todo. "This should break the eventual cycle, but could have a more general solution"
	indices = self widget selectedIndices
		ifTrue: [ ^ self ].

	Halt if:[ indices size > 1 ]. "Not yet implemented for multiple selection"

	indices isEmpty
		ifTrue: [ widget deselectAll ]
		ifFalse: [ widget selectOne: indices anyOne ]

]

{ #category : #'widget creation' }
SpBrickListLikeAdapter >> strongSelectionChangedToIndex: itemIndex [
	"Inspired on SpMorphicListAdapter>>#strongSelectionChanged:"

	self presenter activatesOnDoubleClick
		ifTrue: [ self presenter doubleClickAtIndex: itemIndex ]
]

{ #category : #'widget creation' }
SpBrickListLikeAdapter >> subscribeToPresenter [
	"Subscribe to the presenter so the widget updates on every change announcement."

	self presenter
		whenModelChangedDo: [ self updateItems ].";
		whenSelectionChangedDo: [ self refreshWidgetSelection ]."
		
	self presenter verticalAlignment
		whenChangedDo: [ self updateScrollBar ].

]

{ #category : #'widget creation' }
SpBrickListLikeAdapter >> subscribeToWidget [

	widget
		when: BrSelectionChanged
			do: [ :anEvent | self presenterUpdateSelection: anEvent ];
		when: BrSelectionDoubleClicked
			do: [ :anEvent |
				anEvent selection ifNotEmpty: [ :theIndices | 
					self strongSelectionChangedToIndex: theIndices first ] ].
]

{ #category : #'widget update' }
SpBrickListLikeAdapter >> updateAll [

	super updateAll.
	self
		updateItems;
		updateScrollBar
]

{ #category : #'widget update' }
SpBrickListLikeAdapter >> updateEnabled [
	"Overriden to do nothing. Morphic backend also ignores this property."
	
	self flag: #todo. "refactoring?"
]

{ #category : #'widget update' }
SpBrickListLikeAdapter >> updateItems [

	widget deselectAll.
	widget items: self presenter items
]

{ #category : #'widget creation' }
SpBrickListLikeAdapter >> updateScrollBar [

	widget scrollToIndex:
		self presenter verticalAlignment desiredVisibleRow
]
