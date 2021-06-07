Class {
	#name : #SpBrickListAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'item element' }
SpBrickListAdapter >> bind: anItemElement with: anItem [

	self presenter hasIcons ifTrue: [
		(anItemElement childWithId: #theIcon)
			background: (BlImageBackground image: (self presenter iconFor: anItem)) ].
	(anItemElement childWithId: #theLabel)
		text: (self presenter displayValueFor: anItem).

	^ anItemElement

]

{ #category : #accessing }
SpBrickListAdapter >> elementAt: anInteger [

	^ widget viewModel itemAt: anInteger
]

{ #category : #'widget creation' }
SpBrickListAdapter >> initialAptitude [

	^ BrSimpleListAptitude + BrGlamorousListWithScrollbarAptitude
	  + BrGlamorousButtonExteriorAptitude
]

{ #category : #'item element' }
SpBrickListAdapter >> newBrickItem [
	"Answer a BlElement that can be used to represent a list item."

	| iconElement labelElement |
	
	iconElement := BlElement new
		               size: 16 asPoint;
		               margin: (BlInsets
				                top: 3
				                left: 3
				                bottom: 3
				                right: 0);
		               yourself.

	labelElement := BrLabel new
		                aptitude: BrGlamorousListLabelAptitude new;
		                yourself.

	^ BrHorizontalPane new
		  hMatchParent;
		  vFitContent;
		  aptitude: (BrStyleCommonAptitude new
				   selected: [ :aStyle | 
					   aStyle background: BrGlamorousColors selectedListItemColor ];
				   hovered: [ :aStyle | 
					   aStyle background: BrGlamorousColors hoveredListItemColor ];
				   yourself);
		  addChild: iconElement as: #theIcon;
		  addChild: labelElement as: #theLabel;
		  yourself
]

{ #category : #'widget creation' }
SpBrickListAdapter >> newBrickWidget [

	^ BrSimpleList new
		  itemStencil: [ self newBrickItem ];
		  itemDataBinder: [ :anItemElement :anItem | 
			  self bind: anItemElement with: anItem ];
		  yourself
]

{ #category : #'as yet unclassified' }
SpBrickListAdapter >> presenterUpdateSelection: aBrSelectionChanged [ 
	"Inform the presenter with the new selection"
	
	self presenter selection selectIndexes: aBrSelectionChanged indices
]

{ #category : #refreshing }
SpBrickListAdapter >> refreshList [

	widget invalidate
]

{ #category : #factory }
SpBrickListAdapter >> refreshWidgetSelection [
	"Act after a change in the presenter's selection. This could be a change in:
	- the selection mode (simple, multiple)
	- the selected item(s)
	- initialization on build process
	"

	| indices |
	#refreshWidgetSelection traceCr.
	
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
SpBrickListAdapter >> strongSelectionChangedToIndex: itemIndex [
	"Inspired on SpMorphicListAdapter>>#strongSelectionChanged:"

	self presenter activatesOnDoubleClick
		ifTrue: [ self presenter doubleClickAtIndex: itemIndex ]
]

{ #category : #'widget creation' }
SpBrickListAdapter >> subscribeToPresenter [
	"Subscribe to the presenter so the widget updates on every change announcement."

	self presenter
		whenModelChangedDo: [ self updateItems ]";
		whenSelectionChangedDo: [ self refreshWidgetSelection ]."
]

{ #category : #'widget creation' }
SpBrickListAdapter >> subscribeToWidget [

	widget
		when: BrSelectionChanged
			do: [ :anEvent | self presenterUpdateSelection: anEvent ];
		when: BrSelectionDoubleClicked
			do: [ :anEvent |
				anEvent selection ifNotEmpty: [ :theIndices | 
					self strongSelectionChangedToIndex: theIndices first ] ].
]

{ #category : #updating }
SpBrickListAdapter >> updateAll [

	super updateAll.
	self updateItems
]

{ #category : #updating }
SpBrickListAdapter >> updateEnabled [
	"Overriden to do nothing. Morphic backend also ignores this property."
	
	self flag: #todo. "refactoring?"
]

{ #category : #updating }
SpBrickListAdapter >> updateItems [

	widget deselectAll.
	widget items: self presenter items
]
