Class {
	#name : #SpBrickTextInputFieldAdapter,
	#superclass : #SpBrickAbstractTextAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickTextInputFieldAdapter >> initialAptitude [

	^ BrGlamorousRegularEditorAptitude + "BrGlamorousButtonExteriorAptitude" (BrStyleCommonAptitude new
			default: [ :aStyle | 
				aStyle
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

{ #category : #'widget creation' }
SpBrickTextInputFieldAdapter >> newBrickWidget [

	^ SpBrickTextField new

]
