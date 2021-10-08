Class {
	#name : #SpBrickImageAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#instVars : [
		'nullIcon'
	],
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

{ #category : #accessing }
SpBrickImageAdapter >> nullIcon [

	^ nullIcon ifNil: [ nullIcon := Form extent: 0 asPoint ]
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

	| iconForm |
	iconForm := self presenter image ifNil: [ self nullIcon ].

	widget icon: iconForm
]
