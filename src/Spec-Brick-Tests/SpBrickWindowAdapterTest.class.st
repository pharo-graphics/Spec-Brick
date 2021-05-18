Class {
	#name : #SpBrickWindowAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#instVars : [
		'window',
		'space'
	],
	#category : #'Spec-Brick-Tests'
}

{ #category : #tests }
SpBrickWindowAdapterTest >> closeWindow [
	
"	self waitEmptySpaceTaskQueue."
	"Why doesn't it work if I send to presenter directly?"
	window adapter close.
	self waitSpaceTaskQueueIsEmpty.
]

{ #category : #tests }
SpBrickWindowAdapterTest >> newPresenter [

	^ (self newApplication new: SpWindowPresenter)
		presenter: SpLabelPresenter new;
		yourself
]

{ #category : #tests }
SpBrickWindowAdapterTest >> openWindow [

	window openWithSpecLayout: SpLabelPresenter defaultSpec.
	50 milliSeconds wait.
	space := window adapter widget.

]

{ #category : #tests }
SpBrickWindowAdapterTest >> setUp [

	super setUp.
	
	window := self newPresenter.
]

{ #category : #tests }
SpBrickWindowAdapterTest >> tearDown [

	self closeWindow.

	super tearDown
]

{ #category : #tests }
SpBrickWindowAdapterTest >> testClose [

	self openWindow.
	self closeWindow.
	self assert: window isClosed.
	

]

{ #category : #tests }
SpBrickWindowAdapterTest >> testLifeCycleSubscriptions [

	| openedTime closedTime willCloseTime |
	window whenOpenedDo: [ openedTime := DateAndTime now. 10 milliSeconds wait ].
	window whenWillCloseDo: [ willCloseTime := DateAndTime now. 10 milliSeconds wait ].
	window whenClosedDo: [ closedTime := DateAndTime now. 10 milliSeconds wait ].
	
	self openWindow.
	
	self deny: openedTime isNil.
	self assert: willCloseTime isNil.
	self assert: closedTime isNil.
	
	"Closing BlSpace must trigger the Spec action."
	window adapter widget close.
	self waitSpaceTaskQueueIsEmpty.

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

	self assert: window isClosed.
	self openWindow.
	self deny: window isClosed.
]

{ #category : #tests }
SpBrickWindowAdapterTest >> testTitle [

	self openWindow.
	self assert: space title equals: window title.
	space title: 'This is not a test'.
	self assert: space title equals: 'This is not a test'.
]

{ #category : #tests }
SpBrickWindowAdapterTest >> waitSpaceTaskQueueIsEmpty [

	self assert: (self waitSpaceTaskQueueIsEmptyTimeout: 100 milliSeconds)
]

{ #category : #tests }
SpBrickWindowAdapterTest >> waitSpaceTaskQueueIsEmptyTimeout: aDuration [
	"Wait BlSpace no available tasks to execute. This is important since the SpBrick adapters are usually not synchronous. They enqueue tasks.
	
	Inspired in BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:"

	| startTime timeoutCondition emptyCondition |
	startTime := space time now.
	space time 
		every: 20 milliSeconds
		while: [ 
			timeoutCondition := space time now < (startTime + aDuration).
			emptyCondition := space taskQueue isEmpty not.
			'tick' traceCr.
			timeoutCondition and: [ emptyCondition ] ]
		do: [ space pulse ].

	^ timeoutCondition
]
