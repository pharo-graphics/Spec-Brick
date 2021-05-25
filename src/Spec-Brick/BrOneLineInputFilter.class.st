Class {
	#name : #BrOneLineInputFilter,
	#superclass : #BrTextEditorInputFilter,
	#category : #'Spec-Brick'
}

{ #category : #accessing }
BrOneLineInputFilter >> filter: aString [
	<return: #String>
	
	^ aString reject: #isLineSeparator
]
