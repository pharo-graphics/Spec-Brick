Class {
	#name : #SpBrickAdapterTest,
	#superclass : #TestCase,
	#category : #'Spec-Brick-Tests'
}

{ #category : #running }
SpBrickAdapterTest >> newApplication [

	^ SpApplication new
		  useBackend: #Brick;
		  yourself
]

{ #category : #tests }
SpBrickAdapterTest >> openPresenter: aPresenterFactoryBlock thenDo: anotherBlock [

	| app aPresenter aWindowPresenter |
	app := self newApplication.
	
	aPresenter := aPresenterFactoryBlock value: app.

	aWindowPresenter := aPresenter openWithSpec.

	anotherBlock value: aPresenter.

	aWindowPresenter close.

]
