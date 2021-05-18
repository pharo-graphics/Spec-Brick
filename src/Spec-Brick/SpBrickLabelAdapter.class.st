Class {
	#name : #SpBrickLabelAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick'
}

{ #category : #'widget creation' }
SpBrickLabelAdapter >> buildWidget [

	^ BrLabel new
		  aptitude: BrGlamorousLabelAptitude new;
		  yourself
]

{ #category : #factory }
SpBrickLabelAdapter >> subscribeToModel [

	self presenter whenLabelChangedDo: [ self updateText ]
]

{ #category : #'widget update' }
SpBrickLabelAdapter >> updateAll [

	self updateText.
]

{ #category : #'widget update' }
SpBrickLabelAdapter >> updateText [

	self widgetDo: [ :w | w text: self presenter label ]
]
