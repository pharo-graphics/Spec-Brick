Class {
	#name : #SpBrickToolbarButtonAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#instVars : [
		'nullIcon'
	],
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickToolbarButtonAdapter >> initialAptitude [

	^ BrVerticalFlowAptitude new
	  + BrGlamorousButtonIconAptitude new
	  + BrGlamorousButtonLabelAptitude new
]

{ #category : #'widget creation' }
SpBrickToolbarButtonAdapter >> newBrickWidget [

	^ BrButton new
		  beTinySize;
		  yourself
]

{ #category : #accessing }
SpBrickToolbarButtonAdapter >> nullIcon [

	^ nullIcon ifNil: [ nullIcon := Form extent: 0 asPoint ]
]

{ #category : #'widget creation' }
SpBrickToolbarButtonAdapter >> subscribeToPresenter [

	self flag: #todo. "This class has several clones from SpBrickButtonAdapter with few diffs."
	self presenter
		whenLabelChangedDo: [ self updateLabel ];
		whenIconChangedDo: [ self updateIcon ]
]

{ #category : #'widget update' }
SpBrickToolbarButtonAdapter >> updateAction [

	widget action: self presenter action
]

{ #category : #'widget update' }
SpBrickToolbarButtonAdapter >> updateAll [

	super updateAll.
	self
		updateLabel;
		updateIcon;
		updateAction.
]

{ #category : #'widget update' }
SpBrickToolbarButtonAdapter >> updateIcon [

	| iconForm |
	iconForm := self presenter icon ifNil: [ self nullIcon ].

	widget icon: iconForm
]

{ #category : #'widget update' }
SpBrickToolbarButtonAdapter >> updateLabel [

	widget label: self presenter label
]
