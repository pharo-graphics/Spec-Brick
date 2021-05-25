Class {
	#name : #SpBrickButtonAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick'
}

{ #category : #'widget creation' }
SpBrickButtonAdapter >> buildWidget [

	^ BrButton new
		  aptitude: BrGlamorousButtonWithIconAndLabelAptitude new;
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

	self
		updateLabel;
		updateIcon;
		updateAction.
]

{ #category : #'widget update' }
SpBrickButtonAdapter >> updateIcon [

	self widgetDo: [ :w | 
		
	"TODO"
	self presenter icon ifNotNil: [
		w icon: self presenter icon ] ]
]

{ #category : #'widget update' }
SpBrickButtonAdapter >> updateLabel [

	self widgetDo: [ :w | w label: self presenter label ]
]
