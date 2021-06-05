Class {
	#name : #SpBrickListAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #accessing }
SpBrickListAdapter >> elementAt: anInteger [

	^ widget viewModel itemAt: anInteger
]

{ #category : #'widget creation' }
SpBrickListAdapter >> initialAptitude [

	^ BrSimpleListAptitude + BrGlamorousListWithScrollbarAptitude
	  + BrGlamorousButtonExteriorAptitude
]

{ #category : #'as yet unclassified' }
SpBrickListAdapter >> itemReceivedSingleClick: aBlClickEvent [ 
	"widgetAnnouncedClick:"
1 halt.
	self presenter selection isMultipleSelection ifTrue: [ 1 halt ].

"	self presenter selection
				selectIndex: (ann newSelectedIndexes
					ifNotEmpty: [ :indexes | indexes first ]
					ifEmpty: [ 0 ])"
]

{ #category : #'widget creation' }
SpBrickListAdapter >> newBrickWidget [

	^ BrSimpleList new
		itemStencil: [ self newItemStencil ];
		itemDataBinder: [ :anItemElement :anItem | 
			anItemElement text: (self presenter displayValueFor: anItem) ];
		yourself
]

{ #category : #updating }
SpBrickListAdapter >> newItemStencil [
	"Answer a BlElement that can be used to represent a list item."

	^ BrLabel new
		  hMatchParent;
		  aptitude:
			  BrGlamorousListLabelAptitude new + (BrStyleCommonAptitude new
					   selected: [ :aStyle | 
						   aStyle background: BrGlamorousColors selectedListItemColor ];
					   hovered: [ :aStyle | 
						   aStyle background: BrGlamorousColors hoveredListItemColor ];
					   yourself);
"		  padding: (BlInsets all: 3);"
		  "		  beSmallSize;""		  aptitude: BrGlamorousListLabelAptitude;
		  addAptitude: (BrStyleCommonAptitude new
				   hovered: [ :aStyle | 
					   aStyle background: BrGlamorousColors defaultButtonBorderColor ];
				   yourself);
""			addEventHandlerOn: BlClickEvent
				do: [ :event | self itemReceivedSingleClick: event ];
			addEventHandlerOn: BlDoubleClickEvent
				do: [ :event | self itemReceivedDoubleClick: event ];"
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
		do: [ :event | self presenterUpdateSelection: event ]
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
