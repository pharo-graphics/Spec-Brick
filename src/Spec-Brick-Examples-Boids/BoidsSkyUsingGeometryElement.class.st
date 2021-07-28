"
I'm an example of drawing boids simulation by using Element and Geometry: each boid is the model of aBlElement (See #boid: method), and the element updates it's transformation un demand from such model sending #updateFromBoid.

See an example on class side.
"
Class {
	#name : #BoidsSkyUsingGeometryElement,
	#superclass : #BlElement,
	#instVars : [
		'steppingAnimation',
		'simulation'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-Bloc2'
}

{ #category : #examples }
BoidsSkyUsingGeometryElement class >> exampleWithManyBoids [

	| exampleElement |
	exampleElement := self new
		  ensureStepping;
		  yourself.

	exampleElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	^ exampleElement openInNewSpace

]

{ #category : #accessing }
BoidsSkyUsingGeometryElement >> ensureNotStepping [
	
	steppingAnimation ifNotNil: [
		steppingAnimation stop.
		steppingAnimation := nil ]
]

{ #category : #accessing }
BoidsSkyUsingGeometryElement >> ensureStepping [

	steppingAnimation ifNil: [
		steppingAnimation := self newSteppingAnimation.
		self addAnimation: steppingAnimation ]

]

{ #category : #initialization }
BoidsSkyUsingGeometryElement >> initialize [

	super initialize.
	self initializeSimulation.
	self background: Color lightGray.
	self subscribeResizing.
]

{ #category : #initialization }
BoidsSkyUsingGeometryElement >> initializeSimulation [
	
	simulation := BoidsSimulation exampleWithManyBoids.
	simulation extent: self size asIntegerPoint.

	simulation boids do: [ :each |
		self addChild: (self newElementForBoid: each) ].
]

{ #category : #testing }
BoidsSkyUsingGeometryElement >> isSteppingAnimation [

	^ steppingAnimation isRunning
]

{ #category : #initialization }
BoidsSkyUsingGeometryElement >> newElementForBoid: aBoid [

	^ BlElement new
			boid: aBoid;
			size: aBoid extent;
			background: aBoid color;
			border: (BlBorder paint: aBoid color muchDarker width: 2);
			geometry: BlTriangleGeometry "BlBoidGeometry" new;
			yourself

]

{ #category : #initialization }
BoidsSkyUsingGeometryElement >> newSteppingAnimation [

	^ BlNumberTransition new
		  from: 0;
		  to: 1;
		  onStepDo: [ :t | self step ];
		  beInfinite;
		  yourself
]

{ #category : #accessing }
BoidsSkyUsingGeometryElement >> simulation [

	^ simulation
]

{ #category : #accessing }
BoidsSkyUsingGeometryElement >> step [

	simulation move.
	self updateChildrenFromBoids.
	self invalidate.
]

{ #category : #initialization }
BoidsSkyUsingGeometryElement >> subscribeResizing [

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent | simulation extent: self size ]
]

{ #category : #accessing }
BoidsSkyUsingGeometryElement >> updateChildrenFromBoids [
	
	self childrenDo: [:each | each updateFromBoid ]

]
