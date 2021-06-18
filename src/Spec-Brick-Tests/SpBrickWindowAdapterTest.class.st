Class {
	#name : #SpBrickWindowAdapterTest,
	#superclass : #SpBrickWindowLikeAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #hook }
SpBrickWindowAdapterTest >> openSpecWindow [

	specWindow := specContent openWithSpec.
	brickWindow := specWindow adapter widget
]

{ #category : #running }
SpBrickWindowAdapterTest >> setUp [

	super setUp.
	specContent := self newApplication new: SpBrickStubPresenter.

]
