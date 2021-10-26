"
I'm a sky of boids, where each of them is expressed as a custom geometry.

See example on my class-side.

TODO: It is not drawing well the boids into the canvas.
"
Class {
	#name : #BoidCustomGeometrySkyElement,
	#superclass : #BlElement,
	#instVars : [
		'steppingAnimation',
		'simulation'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-Bloc'
}

{ #category : #examples }
BoidCustomGeometrySkyElement class >> exampleElement [

	| exampleElement |
	exampleElement := self new
		  ensureStepping;
		  yourself.

	exampleElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	^ exampleElement
]

{ #category : #examples }
BoidCustomGeometrySkyElement class >> exampleOpenInNewSpace [

	^ self exampleElement openInNewSpace
]

{ #category : #accessing }
BoidCustomGeometrySkyElement >> ensureNotStepping [
	
	steppingAnimation ifNotNil: [
		steppingAnimation stop.
		steppingAnimation := nil ]
]

{ #category : #accessing }
BoidCustomGeometrySkyElement >> ensureStepping [

	steppingAnimation ifNil: [
		steppingAnimation := self newSteppingAnimation.
		self addAnimation: steppingAnimation ]

]

{ #category : #initialization }
BoidCustomGeometrySkyElement >> initialize [

	super initialize.
	self initializeSimulation.
	self background: Color lightGray.
	self subscribeResizing.
]

{ #category : #initialization }
BoidCustomGeometrySkyElement >> initializeSimulation [
	
	simulation := BoidsSimulation exampleWithManyBoids.
	simulation extent: self size asIntegerPoint.

	simulation boids do: [ :each |
		self addChild: (self newElementForBoid: each) ].
]

{ #category : #testing }
BoidCustomGeometrySkyElement >> isSteppingAnimation [

	^ steppingAnimation isRunning
]

{ #category : #initialization }
BoidCustomGeometrySkyElement >> newElementForBoid: aBoid [

	^ BlElement new
			boid: aBoid;
			size: aBoid extent;
			background: aBoid color;
			border: (BlBorder paint: aBoid color muchDarker width: 2);
			geometry: BoidCustomGeometry new;
			yourself

]

{ #category : #initialization }
BoidCustomGeometrySkyElement >> newSteppingAnimation [

	^ BlNumberTransition new
		  from: 0;
		  to: 1;
		  onStepDo: [ :t | self step ];
		  beInfinite;
		  yourself
]

{ #category : #accessing }
BoidCustomGeometrySkyElement >> simulation [

	^ simulation
]

{ #category : #accessing }
BoidCustomGeometrySkyElement >> step [

	simulation move.
	self invalidate.
]

{ #category : #initialization }
BoidCustomGeometrySkyElement >> subscribeResizing [

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent | simulation extent: self size ]
]
