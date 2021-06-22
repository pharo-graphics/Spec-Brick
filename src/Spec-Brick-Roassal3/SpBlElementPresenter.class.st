Class {
	#name : #SpBlElementPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#element => ObservableSlot'
	],
	#category : #'Spec-Brick-Roassal3'
}

{ #category : #specs }
SpBlElementPresenter class >> adapterName [
	^ #SpBrickBlElementAdapter
]

{ #category : #api }
SpBlElementPresenter >> element [

	^ element
]

{ #category : #api }
SpBlElementPresenter >> element: aBlElement [ 
	
	element := aBlElement
]

{ #category : #'api - events' }
SpBlElementPresenter >> whenElementChangedDo: aBlockClosure [

	self property: #element whenChangedDo: aBlockClosure
]
