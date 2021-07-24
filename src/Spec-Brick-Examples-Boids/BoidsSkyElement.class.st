Class {
	#name : #BoidsSkyElement,
	#superclass : #BlElement,
	#instVars : [
		'steppingAnimation',
		'simulation'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-Bloc'
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

	simulation boids do: [ :each |
		self
			drawOnSpartaCanvas: aCanvas bodyOf: each;
			drawOnSpartaCanvas: aCanvas velocityOf: each ]

]

{ #category : #drawing }
BoidsSkyElement >> drawOnSpartaCanvas: aCanvas bodyOf: aBoid [
	"Draw the body of a boid."
	
	| aPath |
	aPath := aCanvas shape
		circleAt: aBoid position
		radius: aBoid radius.
	
	aCanvas figure
		path: aPath;
		background: aBoid color;
		border: aBoid color muchDarker;
		width: 1;
		draw

]

{ #category : #drawing }
BoidsSkyElement >> drawOnSpartaCanvas: aCanvas velocityOf: aBoid [
	"Draw the tail of the boid, that indicates it's speed."

	| aPath |
	aPath := aCanvas shape
		line: aBoid position
		to: aBoid position - aBoid velocity.
	
	aCanvas figure
		path: aPath;
		border: aBoid color muchDarker;
		width: 1;
		draw

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
	self background: Color lightGray.

	self initializeSimulation.
	self subscribeResizing.
	self subscribeClick.
]

{ #category : #initialization }
BoidsSkyElement >> initializeSimulation [
	
	simulation := BoidsSimulation exampleWithManyBoids.
	simulation extent: self size asIntegerPoint.

]

{ #category : #testing }
BoidsSkyElement >> isSteppingAnimation [

	^ steppingAnimation isNotNil
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
BoidsSkyElement >> subscribeClick [

	self
		addEventHandlerOn: BlClickEvent
		do: [ :anEvent |
			simulation addRandomBoid position: anEvent localPosition.
				self invalidate; requestLayout. ]
]

{ #category : #initialization }
BoidsSkyElement >> subscribeResizing [

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent | simulation extent: self size asIntegerPoint ]
]
