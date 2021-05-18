Class {
	#name : #SpBrickButtonAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick'
}

{ #category : #factory }
SpBrickButtonAdapter >> buildWidget [

	^ BrButton new
		  aptitude: BrGlamorousButtonWithIconAndLabelAptitude new;
		  yourself

]

{ #category : #factory }
SpBrickButtonAdapter >> subscribeToModel [

	self presenter
		whenLabelChangedDo: [ self updateLabel ];
		whenIconChangedDo: [ self updateIcon ];
		whenActionChangedDo: [ self updateAction ]
]

{ #category : #update }
SpBrickButtonAdapter >> updateAction [

	self widgetDo: [ :w | w action: self presenter action ]
]

{ #category : #'updating screen' }
SpBrickButtonAdapter >> updateAll [

	self
		updateLabel;
		updateIcon;
		updateAction.
]

{ #category : #update }
SpBrickButtonAdapter >> updateIcon [

	self widgetDo: [ :w | 
		
	"TODO"
	self presenter icon ifNotNil: [
		w icon: self presenter icon ] ]
]

{ #category : #update }
SpBrickButtonAdapter >> updateLabel [

	self widgetDo: [ :w | w label: self presenter label ]
]
