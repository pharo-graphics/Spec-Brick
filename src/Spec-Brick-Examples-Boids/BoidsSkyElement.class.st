Class {
	#name : #BoidsSkyElement,
	#superclass : #BlElement,
	#instVars : [
		'steppingAnimation',
		'simulation'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-SpecBloc'
}

{ #category : #examples }
BoidsSkyElement class >> exampleWithManyBoids [

	^ self new
		  ensureStepping;
		  yourself
]

{ #category : #drawing }
BoidsSkyElement >> drawOnSpartaCanvas: aCanvas [

	super drawOnSpartaCanvas: aCanvas.

	simulation boids do: [ :eachBoid | 
		eachBoid drawOnSpartaCanvas: aCanvas ]
]

{ #category : #accessing }
BoidsSkyElement >> ensureNotStepping [
	
	steppingAnimation ifNotNil: [
		steppingAnimation stop.
		steppingAnimation := nil ]
]

{ #category : #accessing }
BoidsSkyElement >> ensureStepping [

	steppingAnimation ifNil: [
		steppingAnimation := self newSteppingAnimation.
		self addAnimation: steppingAnimation ]

]

{ #category : #initialization }
BoidsSkyElement >> initialize [

	super initialize.
	self initializeSimulation.
	self background: Color lightGray.
	self subscribeResizing.
]

{ #category : #initialization }
BoidsSkyElement >> initializeSimulation [
	
	simulation := BoidsSimulation exampleWithManyBoids.
	simulation extent: self size asIntegerPoint.

]

{ #category : #testing }
BoidsSkyElement >> isSteppingAnimation [

	^ steppingAnimation isRunning
]

{ #category : #initialization }
BoidsSkyElement >> newSteppingAnimation [

	^ BlNumberTransition new
		  from: 0;
		  to: 1;
		  onStepDo: [ :t | self step ];
		  beInfinite;
		  yourself
]

{ #category : #accessing }
BoidsSkyElement >> simulation [

	^ simulation
]

{ #category : #accessing }
BoidsSkyElement >> step [

	simulation move.
	self invalidate.
]

{ #category : #initialization }
BoidsSkyElement >> subscribeResizing [

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent | simulation extent: self size ]
]
