Class {
	#name : #SpBrickDialogWindowAdapterTest,
	#superclass : #SpBrickWindowLikeAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #hook }
SpBrickDialogWindowAdapterTest >> openSpecWindow [

	specWindow := specContent openDialogWithSpec.
	brickWindow := specWindow adapter widget
]
