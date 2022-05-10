Class {
	#name : #SpBrickDialogWindowAdapterTest,
	#superclass : #SpBrickWindowLikeAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #hook }
SpBrickDialogWindowAdapterTest >> openSpecWindow [

	specWindow := specContent openDialog.
	brickWindow := specWindow adapter widget
]

{ #category : #running }
SpBrickDialogWindowAdapterTest >> setUp [

	super setUp.
	specContent := self newApplication new: SpBrickStubDialogPresenter
]

{ #category : #tests }
SpBrickDialogWindowAdapterTest >> testParentWindow [

	| referenceWindow |
	referenceWindow := (self newApplication new: SpBrickStubPresenter)
		                   initializeWindowBlock: [ :aSpWindow | 
			                   aSpWindow
				                   initialPosition: 200 @ 100;
				                   initialExtent: 400 @ 300 ];
		                   open.
	self waitBlocSpace.

	specContent parentWindow: referenceWindow.
	specContent initializeWindowBlock: [ :aSpWindow | 
		aSpWindow initialExtent: 200 @ 100 ].

	self openSpecWindow.
	self waitBlocSpace.

	self assert: brickWindow position equals: 300 @ 200
]
