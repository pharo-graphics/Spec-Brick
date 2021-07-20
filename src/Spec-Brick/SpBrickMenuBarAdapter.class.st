Class {
	#name : #SpBrickMenuBarAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickMenuBarAdapter >> addMenuGroup: aSpMenuGroupPresenter [

	aSpMenuGroupPresenter menuItems
		do: [ :each | widget addChild: each buildWithSpec ]
		separatedBy: [ self addSeparator ]
]

{ #category : #'widget creation' }
SpBrickMenuBarAdapter >> addSeparator [

	self flag: #todo. "TODO"
]

{ #category : #'widget creation' }
SpBrickMenuBarAdapter >> buildWidget [

	^ BrHorizontalPane new
		  cellSpacing: 5;
		  padding: (BlInsets top: 0 left: 5 bottom: 5 right: 10);
		  margin: (BlInsets horizontal: 5);
		  alignCenterLeft;
		  yourself
]

{ #category : #'widget creation' }
SpBrickMenuBarAdapter >> updateAll [

	super updateAll.
	
	self updateMenuGroups.
]

{ #category : #'widget creation' }
SpBrickMenuBarAdapter >> updateMenuGroups [

	widget removeChildren.
	self presenter menuGroups do: [ :each | self addMenuGroup: each ]
]
