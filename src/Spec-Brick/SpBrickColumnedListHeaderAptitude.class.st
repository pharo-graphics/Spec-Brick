Class {
	#name : #SpBrickColumnedListHeaderAptitude,
	#superclass : #BrAptitude,
	#category : #'Spec-Brick-Widgets-ColumnedList'
}

{ #category : #private }
SpBrickColumnedListHeaderAptitude >> headerPane [

	| headerPane |
	headerPane := BrHorizontalPane new
						  id: #headerPane;
		              padding: (BlInsets bottom: 5);
		              hMatchParent;
		              vFitContent.

	widget viewModel columnsDo: [ :aColumn | 
		| label |
		label := BrLabel new
			         aptitude: BrGlamorousLabelAptitude;
			         beSmallSize;
			         yourself.
		label text: (aColumn title asRopedText foreground:
				 BrGlamorousColors defaultButtonTextColor).
		aColumn width applyOn: label.
		headerPane addChild: label ].

	^ headerPane
]

{ #category : #initialization }
SpBrickColumnedListHeaderAptitude >> initialize [ 

	super initialize.
	self addChangeAddChildFirst: #() with: 
		[ self headerPane ].
]
