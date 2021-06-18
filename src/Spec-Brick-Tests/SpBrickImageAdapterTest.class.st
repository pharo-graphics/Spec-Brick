"
A SpBrickImageAdapterTest is a test class for testing the behavior of SpBrickImageAdapter
"
Class {
	#name : #SpBrickImageAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #running }
SpBrickImageAdapterTest >> specWidgetClass [

	^ SpImagePresenter
]

{ #category : #tests }
SpBrickImageAdapterTest >> testImage [

	| aForm |
	aForm := self iconNamed: #remove.
	self deny: aForm isNil.

	specWidget image: aForm.

	self assert: brickWidget icon equals: aForm.
]
