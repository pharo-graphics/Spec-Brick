Class {
	#name : #BoidsSkyElement,
	#superclass : #BlElement,
	#instVars : [
		'flock',
		'steppingAnimation'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-SpecBloc'
}

{ #category : #examples }
BoidsSkyElement class >> exampleWith30Boids [

	^ self new
		  addBoids: 30;
		  ensureStepping;
		  yourself
]

{ #category : #accessing }
BoidsSkyElement >> addBoids: anInteger [
	"Add a bunch of new random boids to the flock."

	anInteger timesRepeat: [ 
		flock add:
			(Boid randomInBounds: self extent asIntegerPoint inFlock: flock) ]
]

{ #category : #drawing }
BoidsSkyElement >> drawOnSpartaCanvas: aCanvas [
	super drawOnSpartaCanvas: aCanvas.

	flock do: [ :eachBoid | eachBoid drawOnSpartaCanvas: aCanvas ]
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
	
	flock := OrderedCollection new.
	self background: Color lightGray.
	self subscribeResizing.
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
BoidsSkyElement >> step [

	flock do: [ :eachBoid | eachBoid move ].
	self invalidate.
]

{ #category : #initialization }
BoidsSkyElement >> subscribeResizing [

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent | flock do: [ :each | each bounds: self size ] ]
]
