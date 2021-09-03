Class {
	#name : #SpBrickMenuAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #factory }
SpBrickMenuAdapter >> addMenuGroup: aSpMenuGroupPresenter [

	self flag: #todo. "We're just flatttening all groups."
	widget items: widget items, aSpMenuGroupPresenter menuItems
]

{ #category : #factory }
SpBrickMenuAdapter >> buildWidget [

	^ SpBrickContextMenu new
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
