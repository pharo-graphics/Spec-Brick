Class {
	#name : #SpBrickTextInputFieldAdapter,
	#superclass : #SpBrickAbstractTextAdapter,
	#category : #'Spec-Brick'
}

{ #category : #'widget creation' }
SpBrickTextInputFieldAdapter >> buildWidget [

	^ BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		inputFilter: BrOneLineInputFilter new;
		vFitContent;
		yourself
]

{ #category : #'widget update' }
SpBrickTextInputFieldAdapter >> updateText [

	self widgetDo: [ :w | w text: self presenter text ]
]
