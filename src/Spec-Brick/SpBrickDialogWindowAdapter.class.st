Class {
	#name : #SpBrickDialogWindowAdapter,
	#superclass : #SpBrickWindowLikeAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #API }
SpBrickDialogWindowAdapter >> addPresenterIn: aBlSpace withSpecLayout: aSpExecutableLayout [ 

	super addPresenterIn: aBlSpace withSpecLayout: aSpExecutableLayout.
	
	self updateButtonBar.
]

{ #category : #hook }
SpBrickDialogWindowAdapter >> newRootElement [

	^ SpBrickDialogElement new
]

{ #category : #'widget update' }
SpBrickDialogWindowAdapter >> updateButtonBar [
	"Inspired by SpMorphicDialogWindowAdapter>>#buildButtonBar"

	| aButtonBar |
	aButtonBar := (SpButtonBarPresenter owner: self presenter)
		              placeAtEnd;
		              yourself.

	self presenter buttons do: [ :each | aButtonBar add: each ].

	widget root buttonBar: aButtonBar buildWithSpec
]
