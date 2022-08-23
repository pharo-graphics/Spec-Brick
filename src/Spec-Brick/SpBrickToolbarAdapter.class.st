Class {
	#name : #SpBrickToolbarAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickToolbarAdapter >> initialAptitude [

	^ BrGlamorousToolbarAptitude
]

{ #category : #'widget creation' }
SpBrickToolbarAdapter >> newBrickWidget [

	^ SpBrickToolbarElement new
]

{ #category : #private }
SpBrickToolbarAdapter >> newItemFor: aSpToolbarButtonPresenter [

	^ aSpToolbarButtonPresenter build
]

{ #category : #'widget creation' }
SpBrickToolbarAdapter >> subscribeToPresenter [

	super subscribeToPresenter.
	self presenter whenItemsChangeDo: [ self updateItems ]
]

{ #category : #'widget update' }
SpBrickToolbarAdapter >> updateAll [

	super updateAll.

	self updateItems
]

{ #category : #'widget update' }
SpBrickToolbarAdapter >> updateEnabled [

	self flag: #todo.	
]

{ #category : #'widget update' }
SpBrickToolbarAdapter >> updateItems [

	widget removeAllItems.

	self presenter leftItems do: [ :each | 
		widget addItemLeft: (self newItemFor: each) ].

	self presenter rightItems do: [ :each | 
		widget addItemRight: (self newItemFor: each) ]
]
