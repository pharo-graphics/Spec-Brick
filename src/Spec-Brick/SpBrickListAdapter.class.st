Class {
	#name : #SpBrickListAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick'
}

{ #category : #factory }
SpBrickListAdapter >> initialAptitude [

	^ BrSimpleListAptitude + BrGlamorousListWithScrollbarAptitude
	  + (BrStyleCommonAptitude new
			   default: [ :aStyle | 
				   aStyle border: (BlBorder
							    paint: BrGlamorousColors defaultButtonBackgroundColor
							    width: 1) ];
			   yourself)
]

{ #category : #'as yet unclassified' }
SpBrickListAdapter >> itemReceivedSingleClick: aBlClickEvent [ 
	"widgetAnnouncedClick:"

	self presenter selection isMultipleSelection ifTrue: [ 1 halt ].

"	self presenter selection
				selectIndex: (ann newSelectedIndexes
					ifNotEmpty: [ :indexes | indexes first ]
					ifEmpty: [ 0 ])"
]

{ #category : #factory }
SpBrickListAdapter >> newBrickWidget [

	^ BrSimpleList new

]

{ #category : #updating }
SpBrickListAdapter >> newItemStencil [

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

{ #category : #'widget creation' }
SpBrickListAdapter >> subscribeToPresenter [
	"Subscribe to the presenter so the widget updates on every change announcement."

	self presenter
"		whenIconsChangedDo: [ 1halt ]"

]

{ #category : #updating }
SpBrickListAdapter >> updateAll [

	super updateAll.
	self
		updateAptitude;
		updateItems
]

{ #category : #updating }
SpBrickListAdapter >> updateAptitude [

	widget
		itemStencil: [ self newItemStencil ];
		itemDataBinder: [ :anItemElement :anItem | 
			anItemElement text: (self presenter displayValueFor: anItem) ]
]

{ #category : #updating }
SpBrickListAdapter >> updateItems [

	widget items: self presenter items
]
