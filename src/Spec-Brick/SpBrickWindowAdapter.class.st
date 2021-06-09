Class {
	#name : #SpBrickWindowAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #accessing }
SpBrickWindowAdapter >> addContent: aBlElement toWindow: aBlSpace [ 

"	| containerMorph |
	containerMorph := self newContainerMorph.
	containerMorph layoutFrame: aMorph layoutFrame.

	""add all decorations (menu, toolbar and statusbar)""
	self model hasMenu ifTrue: [ self addMenuTo: containerMorph ].

	self setToolbarTo: containerMorph.

	""Register for changes in the toolbar""
	self model whenToolbarChangedDo: [ self setToolbarTo: containerMorph ].

	containerMorph addMorphBack: aMorph.



	self model hasStatusBar ifTrue: [ self addStatusBarTo: containerMorph ].
	"

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aBlSpace root: aBlElement
]

{ #category : #accessing }
SpBrickWindowAdapter >> addPresenterIn: aBlSpace withSpecLayout: aSpAbstractWidgetLayout [ 

	self presenter isCentered 
		ifTrue: [ 1halt "self centered" ].
	self presenter initialPosition 
		ifNotNil: [ :position | aBlSpace position: position ].
	self presenter initialExtent 
		ifNotNil: [ :extent | aBlSpace extent: extent ].
	
	self 
		addContent: (self presenter presenter buildWithSpecLayout: aSpAbstractWidgetLayout) 
		toWindow: aBlSpace
]

{ #category : #accessing }
SpBrickWindowAdapter >> blocHost [

	^ BlHost pickHost
]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> buildWidget [

	^ BlSpace new
		host: self blocHost;
		yourself
]

{ #category : #accessing }
SpBrickWindowAdapter >> close [

	self widget close
]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> onSpaceClosed [
	"Inspired on SpMorphicWindowAdapter>>#windowClosed"

	self presenter windowIsClosing.
	self presenter windowClosed.
]

{ #category : #accessing }
SpBrickWindowAdapter >> open [

	self widget show.

"	self presenter presenter takeKeyboardFocus."
	self presenter windowIsOpening.

]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> subscribeToPresenter [

	super subscribeToPresenter.
	
	self presenter whenDecorationsChangedDo: [ :aBoolean |
		self updateDecorationsAsBorderless ].

]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> subscribeToWidget [

	widget
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ self onSpaceClosed ]
]

{ #category : #accessing }
SpBrickWindowAdapter >> title: aString [ 

	| localizedTitle |
	localizedTitle := aString ifNotNil: [ :theString | theString localizedForPresenter: self presenter].

	self widgetDo: [ :w | w title: localizedTitle ]
]

{ #category : #accessing }
SpBrickWindowAdapter >> updateAll [

	self updateDecorationsAsBorderless

]

{ #category : #accessing }
SpBrickWindowAdapter >> updateDecorationsAsBorderless [
	
	widget borderless: self presenter hasDecorations not
]
