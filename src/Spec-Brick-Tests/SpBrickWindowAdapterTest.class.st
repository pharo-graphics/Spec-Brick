Class {
	#name : #SpBrickWindowAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #asserting }
SpBrickWindowAdapterTest >> assertCloseWindowPresenter [

	self ensureCloseWindowPresenter.
	self assert: specWindow isClosed description: 'The presenter says it is closed'.
	self deny: space isOpened description: 'The backend widget says it is closed'.

]

{ #category : #asserting }
SpBrickWindowAdapterTest >> assertOpenWindowPresenter [

	specWindow := self newApplication new: SpWindowPresenter.
	"What matters in this test case is the window itself, but some content is needed."
	specWindow presenter: (specWindow instantiate: SpLabelPresenter).
	specWindow openWithSpecLayout: SpLabelPresenter defaultSpec.

	space := specWindow adapter widget.
	self deny: specWindow isClosed description: 'The window presenter says it is NOT opened'.
	150 milliSeconds wait.
	self assert: space isOpened description: 'The Bloc space says it is NOT opened'.

]

{ #category : #tests }
SpBrickWindowAdapterTest >> setUp [

	super setUp.
	
	window := self newPresenter.
]

{ #category : #tests }
SpBrickWindowAdapterTest >> testClose [

	self assertOpenWindowPresenter.
	self assertCloseWindowPresenter.

]

{ #category : #tests }
SpBrickWindowAdapterTest >> testLifeCycleSubscriptions [

	| openedTime closedTime willCloseTime |
	specWindow whenOpenedDo: [ openedTime := DateAndTime now. 10 milliSeconds wait ].
	specWindow whenWillCloseDo: [ willCloseTime := DateAndTime now. 10 milliSeconds wait ].
	specWindow whenClosedDo: [ closedTime := DateAndTime now. 10 milliSeconds wait ].
	
	self assertOpenWindowPresenter.
	
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

	self assertOpenWindowPresenter
]

{ #category : #tests }
SpBrickWindowAdapterTest >> testTitle [

	self assertOpenWindowPresenter.
	self assert: space title equals: specWindow title.
	space title: 'This is not a test'.
	self assert: space title equals: 'This is not a test'.
]
