Class {
	#name : #SpToDoValidationErrorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'messageLabel',
		'theError'
	],
	#category : #'Spec-Brick-Examples-ToDoList-Presenters'
}

{ #category : #specs }
SpToDoValidationErrorPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
	borderWidth: 20;
		add: #messageLabel "expand: false fill: false padding: 50";
		yourself
]

{ #category : #initialization }
SpToDoValidationErrorPresenter >> initializePresenters [

	super initializePresenters.
	
	messageLabel := self newLabel
		label: 'ERROR: ', theError messageText;
		yourself.
]

{ #category : #initialization }
SpToDoValidationErrorPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Validation Error';
		initialExtent: 200 @ 100;
		initialPosition: 100 asPoint.
]

{ #category : #initialization }
SpToDoValidationErrorPresenter >> setModelBeforeInitialization: anError [

	theError := anError
]
