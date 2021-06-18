Class {
	#name : #SpBrickWindowLikeAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#instVars : [
		'specContent'
	],
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #hook }
SpBrickWindowLikeAdapterTest >> openSpecWindow [

	self subclassResponsibility
]

{ #category : #running }
SpBrickWindowLikeAdapterTest >> setUp [

	super setUp.
	specContent := self newApplication new: SpBrickStubPresenter.

]

{ #category : #running }
SpBrickWindowLikeAdapterTest >> tearDown [

	self closeSpecWindow.

	super tearDown.

]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testCentered [

	specContent initializeWindowBlock: [ :aSpWindow | aSpWindow centered ].

	self openSpecWindow.
	self waitBlocSpace.

	"We should find a better way to assert."
	self assert: brickWindow position x > 100.
	self assert: brickWindow position y > 100
]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testClose [

	self openSpecWindow.
	self waitBlocSpace.
	self closeSpecWindow.
	self waitBlocSpace.

	self assert: specWindow isClosed description: 'Spec window is NOT closed'.
	self deny: brickWindow isOpened description: 'Bloc window is NOT closed'.

]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testInitialExtent [

	| aParticularExtent |
	aParticularExtent := 777 @ 888.

	specContent initializeWindowBlock: [ :aSpWindow | 
		aSpWindow initialExtent: aParticularExtent ].

	self openSpecWindow.

	self assert: brickWindow extent equals: aParticularExtent
]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testInitialExtentByDefault [

	| defaultExtent |
	specContent initializeWindowBlock: [ :aSpWindow | 
		defaultExtent := aSpWindow initialExtent ].

	self openSpecWindow.

	self assert: brickWindow extent equals: defaultExtent
]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testInitialPosition [

	| aParticularPosition |
	aParticularPosition := 77 @ 88.

	specContent initializeWindowBlock: [ :aSpWindow | 
		aSpWindow initialPosition: aParticularPosition ].

	self openSpecWindow.

	self assert: brickWindow position equals: aParticularPosition
]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testLifeCycleSubscriptions [

	| openedTime closedTime willCloseTime |
	
	self skip. "There is a misunderstanding from my side here"
	self flag: #todo.
	
	
	specContent initializeWindowBlock: [ :aSpWindow |
		aSpWindow whenOpenedDo: [ openedTime := DateAndTime now. 10 milliSeconds wait ].
		aSpWindow whenWillCloseDo: [ willCloseTime := DateAndTime now. 10 milliSeconds wait ].
		aSpWindow whenClosedDo: [ closedTime := DateAndTime now. 10 milliSeconds wait ] ].
	
	self openSpecWindow.
	self waitBlocSpace.

	self deny: openedTime isNil.
	self assert: willCloseTime isNil.
	self assert: closedTime isNil.
	
	"Closing BlSpace must trigger the Spec action."
	brickWindow close.
	self waitBlocSpace.

	"All timestamps are set"
	self deny: openedTime isNil.
	self deny: willCloseTime isNil.
	self deny: closedTime isNil.

	"They have the right order"
	self assert: openedTime <= willCloseTime.
	self assert: willCloseTime <= closedTime.
]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testOpen [
"	brickWindow host universe tryToRunDeferredActions."

	self openSpecWindow.
	self waitBlocSpace.

	self deny: specWindow isClosed description: 'Spec window is NOT opened'.
	self assert: brickWindow isOpened description: 'Bloc space is NOT opened'.

]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testTitle [

	self openSpecWindow.

	"Test with default title"
	self assert: brickWindow title equals: specWindow title.

	"Test with a specific title"
	brickWindow title: 'This is not a test'.
	self assert: brickWindow title equals: 'This is not a test'.
]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testWithDecorations [

	"This is the default value... but let's enforce it."
	specContent initializeWindowBlock: [ :aSpWindow | 
		aSpWindow withDecorations ].

	self openSpecWindow.

	self deny: brickWindow borderless
]

{ #category : #tests }
SpBrickWindowLikeAdapterTest >> testWithoutDecorations [

	specContent initializeWindowBlock: [ :aSpWindow | 
		aSpWindow withoutDecorations ].

	self openSpecWindow.

	self assert: brickWindow borderless
]

{ #category : #running }
SpBrickWindowLikeAdapterTest >> waitBlocSpace [

	0.5 second wait
]
