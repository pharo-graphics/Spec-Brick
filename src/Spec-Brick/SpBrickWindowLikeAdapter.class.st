Class {
	#name : #SpBrickWindowLikeAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #API }
SpBrickWindowLikeAdapter >> addPresenterIn: aBlSpace withSpecLayout: aSpExecutableLayout [ 

	self presenter initialExtent 
		ifNotNil: [ :extent | widget extent: extent ].

	self
		updateMenu;
		updateToolbar;
		updateContentWithSpecLayout: aSpExecutableLayout;
		updateStatusBar

]

{ #category : #'widget creation' }
SpBrickWindowLikeAdapter >> buildWidget [

	^ BlSpace new
		  root: self newRootElement;
		  host: self blocHost;
		  yourself
]

{ #category : #API }
SpBrickWindowLikeAdapter >> centered [

	widget center
]

{ #category : #API }
SpBrickWindowLikeAdapter >> centeredRelativeTo: aSpWindowPresenter [
	"Center the the window relative from another Bloc window. 
	The action is deferred becasue this method was sent from presenter during
	dialog initialization, when extent may not be set."

	self defer: [
		| referenceBlSpace deltaFromAnotherSpace |
		referenceBlSpace := aSpWindowPresenter adapter widget.

		deltaFromAnotherSpace :=
			(referenceBlSpace windowExtent - widget windowExtent) // 2.

		widget position: referenceBlSpace position + deltaFromAnotherSpace ]

]

{ #category : #API }
SpBrickWindowLikeAdapter >> close [

	widget close
]

{ #category : #hook }
SpBrickWindowLikeAdapter >> newRootElement [

	^ self subclassResponsibility
]

{ #category : #'event handling' }
SpBrickWindowLikeAdapter >> onSpaceClosed [
	"Inspired on SpMorphicWindowAdapter>>#windowClosed"

	self presenter
		windowIsClosing;
		windowClosed
]

{ #category : #'event handling' }
SpBrickWindowLikeAdapter >> onSpaceShown [

	self defer: [
		"Setting window position was problematic before being showed."

		self presenter initialPosition 
			ifNotNil: [ :position | widget position: position ].
		self presenter isCentered
			ifTrue: [ self centered ].

	"	self presenter presenter takeKeyboardFocus."
		self presenter windowIsOpening ].

]

{ #category : #API }
SpBrickWindowLikeAdapter >> open [
	"Enqueue opening the window after next universe pulse. 
	See #onSpaceShown for posterior initialization."

	widget show
]

{ #category : #protocol }
SpBrickWindowLikeAdapter >> openWithDeferredAction: aBlockClosure [ 

	self open.
	self defer: aBlockClosure
]

{ #category : #'widget creation' }
SpBrickWindowLikeAdapter >> subscribeToPresenter [

	super subscribeToPresenter.

	self presenter
		whenDecorationsChangedDo: [ self updateDecorationsAsBorderless ];
		whenToolbarChangedDo: [ self updateToolbar ]

]

{ #category : #'widget creation' }
SpBrickWindowLikeAdapter >> subscribeToWidget [

	widget
		addEventHandlerOn: BlSpaceClosedEvent do: [ self onSpaceClosed ];
		addEventHandlerOn: BlSpaceShownEvent do: [ self onSpaceShown ]
]

{ #category : #API }
SpBrickWindowLikeAdapter >> title: aString [ 

	widget title: aString
]

{ #category : #accessing }
SpBrickWindowLikeAdapter >> updateAll [
	"Important: this update is done BEFORE window's initializeWindow:"

	self updateDecorationsAsBorderless
]

{ #category : #accessing }
SpBrickWindowLikeAdapter >> updateContentWithSpecLayout: aSpExecutableLayout [

	"Build the presenter of the window, and establish the Brick widget as content of the window."

	widget root content:
		(self presenter presenter buildWithLayout: aSpExecutableLayout)
]

{ #category : #accessing }
SpBrickWindowLikeAdapter >> updateDecorationsAsBorderless [
	
	widget borderless: self presenter hasDecorations not
]

{ #category : #'widget creation' }
SpBrickWindowLikeAdapter >> updateMenu [

	self presenter hasMenu ifFalse: [
		^ widget root removeMenu ].

	"Build new Brick menu from presenter spec and set it."	
	widget root menu: self presenter menu buildWithSpec

]

{ #category : #'widget creation' }
SpBrickWindowLikeAdapter >> updateStatusBar [

	"Inspired on SpAbstractMorphicWindowAdapter>>#addStatusBarTo:"

	self presenter hasStatusBar ifFalse: [ ^ widget root removeStatusBar ].

	"Build new Brick status bar from presenter spec and set it."
	widget root statusBar: self presenter statusBar build
]

{ #category : #'widget creation' }
SpBrickWindowLikeAdapter >> updateToolbar [

	"Inspired on SpAbstractMorphicWindowAdapter>>#setToolbarTo:"

	self presenter hasToolbar ifFalse: [ ^ widget root removeToolbar ].

	"Build new Brick toolbar from presenter spec and set it."
	widget root toolbar: self presenter toolbar build
]
