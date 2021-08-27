Class {
	#name : #SpBrickMenuAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #factory }
SpBrickMenuAdapter >> addMenuGroup: aSpMenuGroupPresenter [

	| items |
	items := aSpMenuGroupPresenter menuItems
		collect: [ :each | each name -> each action ].

	widget items: widget items, items
]

{ #category : #factory }
SpBrickMenuAdapter >> buildWidget [

	^ BrGlamorousSimpleContextMenuContent new
]

{ #category : #'updating screen' }
SpBrickMenuAdapter >> updateAll [

	super updateAll.
	self updateMenuGroups.
]

{ #category : #'updating screen' }
SpBrickMenuAdapter >> updateMenuGroups [

	widget items: #().
	self presenter menuGroups do: [ :each | self addMenuGroup: each ]
]
