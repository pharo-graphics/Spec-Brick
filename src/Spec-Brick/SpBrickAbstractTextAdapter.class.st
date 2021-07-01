Class {
	#name : #SpBrickAbstractTextAdapter,
	#superclass : #SpBrickWidgetAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickAbstractTextAdapter >> initialAptitude [

	^ BrGlamorousRegularEditorAptitude + "BrGlamorousButtonExteriorAptitude" (BrStyleCommonAptitude new
			default: [ :aStyle | 
				aStyle
					padding: (BlInsets all: 5);
					background: BrGlamorousColors defaultButtonBackgroundColor;
					border: (BlBorder
					    paint: BrGlamorousColors defaultButtonBorderColor
					    width: 1) ];
			disabled: [ :aStyle |
				aStyle
					background: BrGlamorousColors disabledButtonBackgroundColor;
					border: (BlBorder
						paint: BrGlamorousColors disabledButtonBorderColor
						width: 1) ]
			yourself)
]

{ #category : #'widget update' }
SpBrickAbstractTextAdapter >> presenterUpdateText [
	"Update the presenter's text from the Brick widget."

	self presenter text: widget text 
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

	widget editor
		addEventHandlerOn: BrTextEditorModifiedEvent
			do: [ self presenterUpdateText ];
		addEventHandlerOn: BrTextEditorTextReplacedEvent
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
