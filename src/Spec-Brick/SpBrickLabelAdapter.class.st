Class {
	#name : #SpBrickLabelAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickLabelAdapter >> initialAptitude [

	^ BrGlamorousLabelAptitude new
]

{ #category : #'widget creation' }
SpBrickLabelAdapter >> newBrickWidget [

	^ BrLabel new
]

{ #category : #'widget creation' }
SpBrickLabelAdapter >> subscribeToPresenter [

	self presenter whenLabelChangedDo: [ self updateText ]
]

{ #category : #'widget update' }
SpBrickLabelAdapter >> updateAll [

	super updateAll.
	self updateText.
]

{ #category : #'widget update' }
SpBrickLabelAdapter >> updateEnabled [
	"Overriden to do nothing."
	
	self flag: #todo. "refactoring?"
]

{ #category : #'widget update' }
SpBrickLabelAdapter >> updateText [

	widget text: self presenter label
]
