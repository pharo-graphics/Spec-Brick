Class {
	#name : #SpBrickAdapterTest,
	#superclass : #TestCase,
	#instVars : [
		'specWindow',
		'brickWindow'
	],
	#category : #'Spec-Brick-Tests'
}

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
SpBrickAdapterTest >> waitUI [

	self assert: (self waitUITimeout: 100 milliSeconds)
]

{ #category : #running }
SpBrickAdapterTest >> waitUITimeout: aDuration [
	"Wait BlSpace doesn't have available tasks to execute. 
	This is important since the SpBrick* adapters are usually not synchronous: they enqueue tasks.
	
	Inspired in BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:"

	| startTime space timeoutCondition emptyCondition |
	(specWindow isNil or:[ specWindow adapter isNil or: [ specWindow adapter widget isNil ] ])
		ifTrue:[ self error: 'Window not yet built' ].

	space := specWindow adapter widget.
	startTime := space time now.
	space time 
		every: 20 milliSeconds
		while: [ 
			timeoutCondition := space time now < (startTime + aDuration).
			emptyCondition := space taskQueue isEmpty not.
			'waitUI' traceCr.
			timeoutCondition and: [ emptyCondition ] ]
		do: [ space pulse ].

	^ timeoutCondition
]
