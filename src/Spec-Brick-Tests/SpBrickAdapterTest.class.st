Class {
	#name : #SpBrickAdapterTest,
	#superclass : #TestCase,
	#instVars : [
		'specWindow',
		'brickWindow'
	],
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #testing }
SpBrickAdapterTest class >> isAbstract [

	^ self = SpBrickAdapterTest 
]

{ #category : #running }
SpBrickAdapterTest >> closeSpecWindow [

	specWindow ifNotNil: [ specWindow close ].

]

{ #category : #running }
SpBrickAdapterTest >> newApplication [

	^ SpApplication new
		  useBackend: #Brick "BrickOnMockedHost";
		  yourself
]

{ #category : #running }
SpBrickAdapterTest >> simulateKeyPress: aBlKeyboardKey on: aBlElement [

	aBlElement inUIProcessDo: [ 
		BlSpace simulateKeyDownOn: aBlElement key: aBlKeyboardKey.
		BlSpace simulateKeyUpOn: aBlElement key: aBlKeyboardKey.
		aBlElement space pulse ]
]

{ #category : #running }
SpBrickAdapterTest >> waitBlocSpace [

	0.5 second wait
]

{ #category : #running }
SpBrickAdapterTest >> waitUI [

	self assert: (self waitUITimeout: 500 milliSeconds)
]

{ #category : #running }
SpBrickAdapterTest >> waitUITimeout: aDuration [
	"Wait BlSpace doesn't have available tasks to execute. 
	This is important since the SpBrick* adapters are usually not synchronous: they defer tasks.
	
	Inspired on BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:"

	| deadlineTime space hasTimedOut hasEmptyTaskQueue |
	(specWindow isNil or: [
		specWindow adapter isNil or: [
			specWindow adapter widget isNil ] ])
				ifTrue:[ self error: 'Window not yet built' ].

	space := specWindow adapter widget.
	deadlineTime := space time now + aDuration.
	space pulse.

	space time
		every: 50 milliSeconds
		while: [
			hasTimedOut := space time now < deadlineTime.
			hasEmptyTaskQueue := space taskQueue isEmpty not.
			hasTimedOut and: [ hasEmptyTaskQueue ] ]
		do: [ 
			#waitUI traceCr.
			space root inUIProcessDo: [ space pulse ].
		].

	^ hasTimedOut
]
