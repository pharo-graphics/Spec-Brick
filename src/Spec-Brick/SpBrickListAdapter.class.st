Class {
	#name : #SpBrickListAdapter,
	#superclass : #SpBrickListLikeAdapter,
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
