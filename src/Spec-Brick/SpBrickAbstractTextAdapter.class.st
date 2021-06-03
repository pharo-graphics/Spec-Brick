Class {
	#name : #SpBrickAbstractTextAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick'
}

{ #category : #'widget creation' }
SpBrickAbstractTextAdapter >> subscribeToPresenter [

	self presenter
		whenTextChangedDo: [ self updateText ];
		whenPlaceholderChangedDo: [ self halt ];
		whenAcceptBlockChangedDo: [ self halt ];
		yourself
]

{ #category : #'widget creation' }
SpBrickAbstractTextAdapter >> subscribeToWidget [

	widget
		addEventHandlerOn: "BrEditorTextChanged"BrTextEditorModifiedEvent
		do: [ self updateText ]
]

{ #category : #'widget update' }
SpBrickAbstractTextAdapter >> updateAll [

	super updateAll.
	self updateText.
]

{ #category : #'widget update' }
SpBrickAbstractTextAdapter >> updateText [

	self subclassResponsibility
]
