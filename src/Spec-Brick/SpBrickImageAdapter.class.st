Class {
	#name : #SpBrickImageAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickImageAdapter >> initialAptitude [

	^ BrGlamorousButtonRectangularAptitude new
	  + BrGlamorousButtonIconAptitude new
]

{ #category : #'widget creation' }
SpBrickImageAdapter >> newBrickWidget [

	^ BrButton new
		  fitContent;
		  yourself
]

{ #category : #'widget creation' }
SpBrickImageAdapter >> subscribeToPresenter [

	self presenter
		whenImageChangeDo: [ self updateImageAsIcon ];
		whenAutoScaleChangeDo: [ self updateAutoScale ]
]

{ #category : #'widget update' }
SpBrickImageAdapter >> updateAll [

	super updateAll.

	self
		updateImageAsIcon;
		updateAutoScale
]

{ #category : #'widget update' }
SpBrickImageAdapter >> updateAutoScale [

	self presenter autoScale
		ifTrue: [ self shouldBeImplemented ]
"		ifFalse: [ numericScale := 1 ].
	widget transformDo: [ :aBuilder | 
		aBuilder
			topLeftOrigin;
			scaleBy: numericScale asPoint ]"
]

{ #category : #'widget update' }
SpBrickImageAdapter >> updateImageAsIcon [

	widget icon: self presenter image
]
