Class {
	#name : #SpBrickButtonAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#instVars : [
		'nullIcon'
	],
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickButtonAdapter >> initialAptitude [

	^ BrGlamorousButtonExteriorAptitude new
	  + BrGlamorousButtonLayoutAptitude new
	  + BrGlamorousButtonIconAptitude new
	  + BrGlamorousButtonLabelAptitude new
	  + (BrStyleCommonAptitude new default: [ :aStyle | 
			   aStyle padding: (BlInsets all: 5) ])
]

{ #category : #'widget creation' }
SpBrickButtonAdapter >> newBrickWidget [

	^ BrButton new
		  hMatchParent;
		  yourself
]

{ #category : #accessing }
SpBrickButtonAdapter >> nullIcon [

	^ nullIcon ifNil: [ nullIcon := Form extent: 0 asPoint ]
]

{ #category : #'widget creation' }
SpBrickButtonAdapter >> subscribeToPresenter [

	self presenter
		whenLabelChangedDo: [ self updateLabel ];
		whenIconChangedDo: [ self updateIcon ];
		whenActionChangedDo: [ self updateAction ]
]

{ #category : #'widget update' }
SpBrickButtonAdapter >> updateAction [

	widget action: self presenter action
]

{ #category : #'widget update' }
SpBrickButtonAdapter >> updateAll [

	super updateAll.
	self
		updateLabel;
		updateIcon;
		updateAction.
]

{ #category : #'widget update' }
SpBrickButtonAdapter >> updateIcon [

	| iconForm |
	iconForm := self presenter icon ifNil: [ self nullIcon ].

	widget icon: iconForm
]

{ #category : #'widget update' }
SpBrickButtonAdapter >> updateLabel [

	widget label: self presenter label
]
