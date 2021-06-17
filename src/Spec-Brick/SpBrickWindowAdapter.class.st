Class {
	#name : #SpBrickWindowAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #accessing }
SpBrickWindowAdapter >> addPresenterIn: aBlSpace withSpecLayout: aSpExecutableLayout [ 

	self presenter isCentered 
		ifTrue: [ 1halt "self centered" ].
	self presenter initialPosition 
		ifNotNil: [ :position | aBlSpace position: position ].
	self presenter initialExtent 
		ifNotNil: [ :extent | aBlSpace extent: extent ].
	
	self
		updateMenu;
		updateToolbar;
		updateContentWithSpecLayout: aSpExecutableLayout;
		updateStatusBar

]

{ #category : #accessing }
SpBrickWindowAdapter >> blocHost [

	^ BlHost pickHost
]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> buildWidget [

	^ BlSpace new
		root: SpBrickWindowElement new;
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

	self presenter
		whenDecorationsChangedDo: [ self updateDecorationsAsBorderless ];
		whenToolbarChangedDo: [ self updateToolbar ]

]

{ #category : #'widget creation' }
SpBrickWindowAdapter >> subscribeToWidget [

	widget
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ self onSpaceClosed ]
]

{ #category : #accessing }
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
