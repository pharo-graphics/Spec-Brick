Class {
	#name : #SpBrickOneLineInputFilter,
	#superclass : #BrTextEditorInputFilter,
	#category : #'Spec-Brick-Text'
}

{ #category : #accessing }
SpBrickOneLineInputFilter >> filter: aString [
	<return: #String>

	^ aString copyWithoutAll: String newCSLineEnders 
]
