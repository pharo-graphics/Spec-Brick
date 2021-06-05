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
	
	self presenter initialPosition 
		ifNotNil: [ :position | 1halt "aWindow position: position" ].
	self presenter initialExtent 
		ifNotNil: [ :extent | aBlSpace extent: extent ].
	self presenter hasDecorations 
		ifFalse: [ 1halt "aWindow removeLabelArea" ].
	self presenter whenDecorationsChangedDo: [ :aBoolean |
		1halt 
		"aBoolean 
			ifTrue: [ aWindow initializeLabelArea ]
			ifFalse: [ aWindow removeLabelArea ]" ].
	
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

	"self defer: ["
		self widget show.

		self presenter initialPosition 
			ifNotNil: [ :aPosition | 1halt "self widget position: aPosition" ].
		self presenter isCentered 
			ifTrue: [ 1halt "self centered" ].

		self presenter windowIsOpening. "]"
	
	self flag: #todo.	
"	self widget openInWorld.
	self presenter initialPosition 
		ifNotNil: [ :aPosition | self widget position: aPosition ].
	self presenter isCentered 
		ifTrue: [ self centered ].
	self presenter presenter takeKeyboardFocus.
	self windowIsOpening"
	

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
