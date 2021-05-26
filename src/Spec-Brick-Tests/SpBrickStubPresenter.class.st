Class {
	#name : #SpBrickStubPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'initializeWindowBlock',
		'contentPresenter'
	],
	#category : #'Spec-Brick-Tests'
}

{ #category : #specs }
SpBrickStubPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #contentPresenter;
		  yourself
]

{ #category : #accessing }
SpBrickStubPresenter >> contentPresenter [

	^ contentPresenter
]

{ #category : #accessing }
SpBrickStubPresenter >> contentPresenter: aSpPresenter [

	contentPresenter := aSpPresenter
]

{ #category : #initialization }
SpBrickStubPresenter >> defaultContentPresenter [

	^ self newLabel
]

{ #category : #initialization }
SpBrickStubPresenter >> initializePresenters [

	"This instance variable could be nil until this moment."
	contentPresenter ifNil: [
		contentPresenter := self defaultContentPresenter ]
]

{ #category : #initialization }
SpBrickStubPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	self initializeWindowBlock value: aWindowPresenter
]

{ #category : #accessing }
SpBrickStubPresenter >> initializeWindowBlock [

	^ initializeWindowBlock ifNil: [ 
		  [ :aWindowPresenter | "do nothing by default" ] ]
]

{ #category : #accessing }
SpBrickStubPresenter >> initializeWindowBlock: aBlockClosure [

	initializeWindowBlock := aBlockClosure
]
