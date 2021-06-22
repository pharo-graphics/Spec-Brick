Class {
	#name : #SpBrickBlElementAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Roassal3'
}

{ #category : #factory }
SpBrickBlElementAdapter >> buildWidget [

	^ SpBrickBlElementContainer new

]

{ #category : #'widget creation' }
SpBrickBlElementAdapter >> subscribeToPresenter [

	super subscribeToPresenter.

	self presenter whenElementChangedDo: [ self updateElement ]
]

{ #category : #'widget creation' }
SpBrickBlElementAdapter >> updateAll [

	super updateAll.
	
	self updateElement
]

{ #category : #'widget creation' }
SpBrickBlElementAdapter >> updateElement [

	widget removeChildren.

	self presenter element ifNotNil: [ :e | widget addChild: e ]
]

{ #category : #updating }
SpBrickBlElementAdapter >> updateEnabled [

	self flag: #todo. "Should be implemented"
]
