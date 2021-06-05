Class {
	#name : #SpBrickButtonAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickButtonAdapter >> initialAptitude [

	"^BrGlamorousButtonWithIconAndLabelAptitude new"

	^ BrGlamorousButtonExteriorAptitude new
	  + BrGlamorousButtonRectangularAptitude new
	  + BrGlamorousButtonIconAptitude new
	  + BrGlamorousButtonLabelAptitude new
]

{ #category : #'widget creation' }
SpBrickButtonAdapter >> newBrickWidget [

	^ BrButton new
		  hMatchParent;
		  yourself
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

	self widgetDo: [ :w | w action: self presenter action ]
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

	"TODO"
	self presenter icon ifNotNil: [
		widget icon: self presenter icon ]
]

{ #category : #'widget update' }
SpBrickButtonAdapter >> updateLabel [

	widget label: self presenter label
]
