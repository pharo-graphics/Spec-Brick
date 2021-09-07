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

	anItemElement userData at: #specModel put: anItem.

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

	| iconElement labelElement itemAptitude |
	
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

	itemAptitude := BrStyleCommonAptitude new
				   selected: [ :aStyle | 
					   aStyle background: BrGlamorousColors selectedListItemColor ];
				   hovered: [ :aStyle | 
					   aStyle background: BrGlamorousColors hoveredListItemColor ];
				   yourself.

	self flag: #todo. "What happens when it's updated?"
	self presenter contextMenu ifNotNil: [
		itemAptitude := itemAptitude + self newContextMenuAptitude ].

	^ BrHorizontalPane new
		  hMatchParent;
		  vFitContent;
		  when: BlMouseDownEvent do: [ :aBlEvent |
				self onMouseDownOnItem: aBlEvent ];
		  aptitude: itemAptitude;
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
		  itemDataUnbinder: [ :anItemElement |
				self unbind: anItemElement ];
		  yourself
]

{ #category : #'item element' }
SpBrickListAdapter >> unbind: anItemElement [

	anItemElement userData removeKey: #specModel

]
