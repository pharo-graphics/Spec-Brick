Class {
	#name : #SpBrickWindowAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#instVars : [
		'specContent'
	],
	#category : #'Spec-Brick-Tests'
}

{ #category : #asserting }
SpBrickWindowAdapterTest >> buildWindowWithPresenterClass: aClass [

	specWindow := self newApplication new: SpWindowPresenter.
	specWindow presenter: (specWindow instantiate: aClass).
	specWindow buildWithSpecLayout: aClass defaultSpec.
	brickWindow := specWindow adapter widget.

]

{ #category : #asserting }
SpBrickWindowAdapterTest >> openSpecWindow [

	specWindow := specContent openWithSpec.
	brickWindow := specWindow adapter widget.

]

{ #category : #asserting }
SpBrickWindowAdapterTest >> setUp [

	super setUp.
	specContent := self newApplication new: SpBrickStubPresenter.

]

{ #category : #asserting }
SpBrickWindowAdapterTest >> tearDown [

	self closeSpecWindow.

	super tearDown.

]

{ #category : #tests }
SpBrickWindowAdapterTest >> testClose [

	self openSpecWindow.

	self closeSpecWindow.

	self assert: specWindow isClosed description: 'Spec window is NOT closed'.
	self deny: brickWindow isOpened description: 'Bloc window is NOT closed'.

]

{ #category : #tests }
SpBrickWindowAdapterTest >> testLifeCycleSubscriptions [

	| openedTime closedTime willCloseTime |
	specContent initializeWindowBlock: [ :aSpWindow |
		aSpWindow whenOpenedDo: [ openedTime := DateAndTime now. 10 milliSeconds wait ].
		aSpWindow whenWillCloseDo: [ willCloseTime := DateAndTime now. 10 milliSeconds wait ].
		aSpWindow whenClosedDo: [ closedTime := DateAndTime now. 10 milliSeconds wait ] ].
	
	self openSpecWindow.
	
	self deny: openedTime isNil.
	self assert: willCloseTime isNil.
	self assert: closedTime isNil.
	
	"Closing BlSpace must trigger the Spec action."
	specWindow adapter widget close.
	self waitUI.

	"All timestamps are set"
	self deny: openedTime isNil.
	self deny: willCloseTime isNil.
	self deny: closedTime isNil.

	"They have the right order"
	self assert: openedTime <= willCloseTime.
	self assert: willCloseTime <= closedTime.
]

{ #category : #tests }
SpBrickWindowAdapterTest >> testOpen [

	self openSpecWindow.
	
	self deny: specWindow isClosed description: 'Spec window is NOT opened'.
	self assert: brickWindow isOpened description: 'Bloc space is NOT opened'.

]

{ #category : #tests }
SpBrickWindowAdapterTest >> testTitle [

	self openSpecWindow.

	"Test with default title"
	self assert: brickWindow title equals: specWindow title.

	"Test with a specific title"
	brickWindow title: 'This is not a test'.
	self assert: brickWindow title equals: 'This is not a test'.
]
