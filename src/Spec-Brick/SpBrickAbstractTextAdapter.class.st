Class {
	#name : #SpBrickAbstractTextAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget update' }
SpBrickAbstractTextAdapter >> presenterUpdateText [
	"Update the presenter's text from the Brick widget."

"1halt.
	SpBrickUpdateCycleBreaker ifNotUpdatingDo: [ 
"		self presenter text: widget text 
]

{ #category : #'widget creation' }
SpBrickAbstractTextAdapter >> subscribeToPresenter [

	self presenter
		whenTextChangedDo: [ self updateText ];
"		whenPlaceholderChangedDo: [ self halt ];
		whenAcceptBlockChangedDo: [ self halt ];"
		yourself
]

{ #category : #'widget creation' }
SpBrickAbstractTextAdapter >> subscribeToWidget [

	widget
		addEventHandlerOn: BrEditorTextChanged
		do: [ self presenterUpdateText ]
]

{ #category : #'widget update' }
SpBrickAbstractTextAdapter >> updateAll [

	super updateAll.
	self updateText.
]

{ #category : #'widget update' }
SpBrickAbstractTextAdapter >> updateText [

	self defer: [ 
		'updateText ' trace.
		self presenter text traceCr.
		
		widget text: self presenter text ]
]
