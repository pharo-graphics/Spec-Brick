Class {
	#name : #SpBrickTextInputFieldAdapter,
	#superclass : #SpBrickAbstractTextAdapter,
	#category : #'Spec-Brick'
}

{ #category : #'widget creation' }
SpBrickTextInputFieldAdapter >> initialAptitude [

	^ BrGlamorousRegularEditorAptitude
]

{ #category : #'widget creation' }
SpBrickTextInputFieldAdapter >> newBrickWidget [

	^ BrEditor new
		hMatchParent;
		vFitContent;
		inputFilter: BrOneLineInputFilter new;
		yourself
]

{ #category : #'widget update' }
SpBrickTextInputFieldAdapter >> updateText [
1halt.
"	widget text: self presenter text"
]
