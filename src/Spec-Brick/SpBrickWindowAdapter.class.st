Class {
	#name : #SpBrickWindowAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #API }
SpBrickWindowAdapter >> addPresenterIn: aBlSpace withSpecLayout: aSpExecutableLayout [ 

	self presenter initialExtent 
		ifNotNil: [ :extent | widget extent: extent ].

	self
		updateMenu;
		updateToolbar;
		updateContentWithSpecLayout: aSpExecutableLayout;
		updateStatusBar

]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> buildWidget [

	^ BlSpace new
		root: SpBrickWindowElement new;
		host: self blocHost;
		yourself
]

{ #category : #API }
SpBrickWindowAdapter >> centered [

	widget center
]

{ #category : #API }
SpBrickWindowAdapter >> close [

	widget close
]

{ #category : #'event handling' }
SpBrickWindowAdapter >> onSpaceClosed [
	"Inspired on SpMorphicWindowAdapter>>#windowClosed"

	self presenter
		windowIsClosing;
		windowClosed
]

{ #category : #'event handling' }
SpBrickWindowAdapter >> onSpaceShown [

	#onSpaceShown1 traceCr.
	self defer: [
		#onSpaceShown2 traceCr.
		"Setting window position was problematic before being showed."
		self presenter initialPosition 
			ifNotNil: [ :position | widget position: position ].
"		self presenter isCentered
			ifTrue: [ self centered ].
"
	"	self presenter presenter takeKeyboardFocus."
		self presenter windowIsOpening ].

]

{ #category : #API }
SpBrickWindowAdapter >> open [
	"Enqueue opening the window after next universe pulse. 
	See #onSpaceShown for posterior initialization."

	widget show
]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> subscribeToPresenter [

	super subscribeToPresenter.

	self presenter
		whenDecorationsChangedDo: [ self updateDecorationsAsBorderless ];
		whenToolbarChangedDo: [ self updateToolbar ]

]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> subscribeToWidget [

	widget
		addEventHandlerOn: BlSpaceClosedEvent do: [ self onSpaceClosed ];
		addEventHandlerOn: BlSpaceShownEvent do: [ self onSpaceShown ]
]

{ #category : #API }
SpBrickWindowAdapter >> title: aString [ 

	widget title: aString
]

{ #category : #accessing }
SpBrickWindowAdapter >> updateAll [
	"Important: this update is done BEFORE window's initializeWindow:"

	self updateDecorationsAsBorderless
]

{ #category : #accessing }
SpBrickWindowAdapter >> updateContentWithSpecLayout: aSpExecutableLayout [
	"Build the presenter of the window, and establish the Brick widget as content of the window."

	widget root content: (self presenter presenter buildWithSpecLayout: aSpExecutableLayout)

]

{ #category : #accessing }
SpBrickWindowAdapter >> updateDecorationsAsBorderless [
	
	widget borderless: self presenter hasDecorations not
]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> updateMenu [

	self presenter hasMenu ifFalse: [
		^ widget root removeMenu ].

	"Build new Brick menu from presenter spec and set it."	
	widget root menu: self presenter menu buildWithSpec

]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> updateStatusBar [
	"Inspired on SpAbstractMorphicWindowAdapter>>#addStatusBarTo:"

	self presenter hasStatusBar ifFalse: [
		^ widget root removeStatusBar ].

	"Build new Brick status bar from presenter spec and set it."	
	widget root statusBar: self presenter statusBar buildWithSpec

]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> updateToolbar [
	"Inspired on SpAbstractMorphicWindowAdapter>>#setToolbarTo:"

	self presenter hasToolbar ifFalse: [
		^ widget root removeToolbar ].

	"Build new Brick toolbar from presenter spec and set it."	
	widget root toolbar: self presenter toolbar buildWithSpec

]
