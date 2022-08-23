Trait {
	#name : #SpBrickTStubPresenter,
	#instVars : [
		'contentPresenter',
		'initializeWindowBlock'
	],
	#category : #'Spec-Brick-Tests-Support'
}

{ #category : #specs }
SpBrickTStubPresenter classSide >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #contentPresenter;
		  yourself
]

{ #category : #accessing }
SpBrickTStubPresenter >> contentPresenter [

	^ contentPresenter
]

{ #category : #accessing }
SpBrickTStubPresenter >> contentPresenter: aSpPresenter [

	contentPresenter := aSpPresenter
]

{ #category : #initialization }
SpBrickTStubPresenter >> defaultContentPresenter [

	^ self newLabel
]

{ #category : #initialization }
SpBrickTStubPresenter >> initializePresenters [

	"This instance variable could be nil until this moment."
	contentPresenter ifNil: [
		contentPresenter := self defaultContentPresenter ]
]

{ #category : #initialization }
SpBrickTStubPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	self initializeWindowBlock value: aWindowPresenter
]

{ #category : #accessing }
SpBrickTStubPresenter >> initializeWindowBlock [

	^ initializeWindowBlock ifNil: [ 
		  [ :aWindowPresenter | "do nothing by default" ] ]
]

{ #category : #accessing }
SpBrickTStubPresenter >> initializeWindowBlock: aBlockClosure [

	initializeWindowBlock := aBlockClosure
]
