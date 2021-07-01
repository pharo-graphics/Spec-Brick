Class {
	#name : #SpBrickButtonBarAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickButtonBarAdapter >> buildWidget [

	^ BrHorizontalPane new
		  cellSpacing: 5;
		  padding: (BlInsets top: 0 left: 5 bottom: 5 right: 10);
		  margin: (BlInsets horizontal: 5);
		  alignCenterRight;
		  addChildren: self newBrickButtons;
		  yourself
]

{ #category : #'widget creation' }
SpBrickButtonBarAdapter >> newBrickButtons [

	^ self presenter items collect: [ :each | 
		  each buildWithSpec
			  hExact: 100;
			  yourself ]
]

{ #category : #'widget update' }
SpBrickButtonBarAdapter >> updateAlignment [

	self presenter isPlaceAtStart
		ifTrue: [ widget alignCenterLeft ]
		ifFalse: [ widget alignCenterRight ]
]

{ #category : #'widget update' }
SpBrickButtonBarAdapter >> updateAll [

	super updateAll.
	
	self 
		updateItems;
		updateAlignment

]

{ #category : #'widget update' }
SpBrickButtonBarAdapter >> updateEnabled [

	self flag: #todo. "Ignore?"
]

{ #category : #'widget update' }
SpBrickButtonBarAdapter >> updateItems [

	widget
		removeChildren;
		addChildren: self newBrickButtons
]
