Class {
	#name : #SpBrickDropListAdapter,
	#superclass : #SpBrickListLikeAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #accessing }
SpBrickDropListAdapter >> elementAt: index [

	^ self presenter getList at: index
]

{ #category : #'widget creation' }
SpBrickDropListAdapter >> initialAptitude [

	^ BrGlamorousButtonWithLabelAndIconAptitude +
			(BrGlamorousWithDropdownAptitude
				handle: [ self newBrickWidgetWhenPopupIsVisible ]
				content: [ self newPopupList ])

]

{ #category : #'widget creation' }
SpBrickDropListAdapter >> newBrickWidget [

	^ BrButton new
"		  hMatchParent;"
		  icon: (BlElement new
				   size: 8 @ 8;
				   geometry: (BlPolygonGeometry vertices: { 
								    (0 @ 0).
								    (8 @ 0).
								    ((8 / 2) rounded @ 8) });
				   background: Color lightGray;
				   margin: (BlInsets left: 6);
				   constraintsDo: [ :c | c linear vertical alignCenter ]);
		  yourself
]

{ #category : #'widget creation' }
SpBrickDropListAdapter >> newBrickWidgetWhenPopupIsVisible [

	| tmp |
	tmp := self newBrickWidget
		       aptitude: BrGlamorousButtonWithLabelAndIconAptitude
			       - BrGlamorousButtonExteriorAptitude;
		       yourself.
	
	self updateFromSelectedItem: tmp.

	^ tmp
]

{ #category : #private }
SpBrickDropListAdapter >> newPopupList [
	
	^ model newList
		display: model display;
		items: model items;
		displayIcon: model iconBlock;
		whenSelectionChangedDo: [ :newSelection | 
			model selectIndex: newSelection selectedIndex.
			widget fireEvent: BrDropdownHideWish new ];
		buildWithSpec
]

{ #category : #'widget creation' }
SpBrickDropListAdapter >> subscribeToPresenter [

	super subscribeToPresenter.
	
	self presenter whenSelectedItemChangedDo:[
		self updateFromSelectedItem ]
]

{ #category : #'widget creation' }
SpBrickDropListAdapter >> updateAll [

	super updateAll.

	self updateFromSelectedItem.
]

{ #category : #'widget creation' }
SpBrickDropListAdapter >> updateFromSelectedItem [

	self updateFromSelectedItem: widget
]

{ #category : #'widget creation' }
SpBrickDropListAdapter >> updateFromSelectedItem: aBrButton [

	| wrappedSelectedItem |
	wrappedSelectedItem := self elementAt: self presenter selectedIndex.

	aBrButton
		label: (self presenter displayForItem: wrappedSelectedItem)";
		icon: (self presenter getIconFor: wrappedSelectedItem)"
]
