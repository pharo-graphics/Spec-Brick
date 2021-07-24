Class {
	#name : #BoidsSimulation,
	#superclass : #Model,
	#instVars : [
		'alignmentRadius',
		'cohesionRadius',
		'separationRadius',
		'boids',
		'separationAdjustment',
		'alignmentAdjustment',
		'cohesionAdjustment',
		'isCircling',
		'extent',
		'boidRadius',
		'velocityLimit'
	],
	#category : #'Spec-Brick-Examples-Boids-Model'
}

{ #category : #examples }
BoidsSimulation class >> exampleWithManyBoids [

	| instance |
	instance := self new.
	instance extent: 100 asPoint. "ToDo"

	"Add a bunch of new random boids."
	50 timesRepeat: [ instance addRandomBoid ].

	^ instance	
]

{ #category : #private }
BoidsSimulation >> addBoid: aBoid [
	"Add a new boid with a initial position and velocity already established."

	^ boids add: aBoid
]

{ #category : #private }
BoidsSimulation >> addRandomBoid [
	"Add a new boid with a random position and velocity. Extent needs to be established as a precondition."

	| position velocity newBoid |
	position := 
		(extent x atRandom) @ 
		(extent y atRandom).

	velocity :=
		(velocityLimit - (2 * velocityLimit) atRandom) @
		(velocityLimit - (2 * velocityLimit) atRandom).
	
	newBoid := self newBoid
		position: position;
		velocity: velocity;
		yourself.
	
	^ self addBoid: newBoid
]

{ #category : #accessing }
BoidsSimulation >> alignmentAdjustment [

	^ alignmentAdjustment
]

{ #category : #accessing }
BoidsSimulation >> alignmentAdjustment: aNumber [

	alignmentAdjustment := aNumber
]

{ #category : #accessing }
BoidsSimulation >> alignmentRadius [

	^ alignmentRadius
]

{ #category : #accessing }
BoidsSimulation >> alignmentRadius: aNumber [

	alignmentRadius := aNumber
]

{ #category : #accessing }
BoidsSimulation >> boids [

	^ boids
]

{ #category : #accessing }
BoidsSimulation >> cohesionAdjustment [

	^ cohesionAdjustment
]

{ #category : #accessing }
BoidsSimulation >> cohesionAdjustment: aNumber [

	cohesionAdjustment := aNumber
]

{ #category : #accessing }
BoidsSimulation >> cohesionRadius [

	^ cohesionRadius
]

{ #category : #accessing }
BoidsSimulation >> cohesionRadius: aNumber [

	cohesionRadius := aNumber
]

{ #category : #accessing }
BoidsSimulation >> extent [
	^ extent
]

{ #category : #accessing }
BoidsSimulation >> extent: aPoint [
	extent := aPoint
]

{ #category : #moving }
BoidsSimulation >> fallThrough: aBoid [
	"If a boid falls off the edge of the bounds, it reappears at the opposite edge.
	At least, if the difference does not exceed one time the extent of the bounds."

	| p |
	p := aBoid position.
	p x < 0 ifTrue: [
		aBoid position: p + (extent x @ 0) ].
	p x > extent x ifTrue: [ 
		aBoid position: p - (extent x @ 0) ].

	p := aBoid position.
	p y < 0 ifTrue: [
		aBoid position: p + (0 @ extent y) ].
	p y > extent y ifTrue: [ 
		aBoid position: p - (0 @ extent y) ]
]

{ #category : #initialization }
BoidsSimulation >> initialize [

	super initialize.

	boids := OrderedCollection new.

	boidRadius := 8.
	velocityLimit := 8.
	
	separationRadius := boidRadius * 3. "steer to avoid crowding of flockmates"
	alignmentRadius := boidRadius * 35. "steer towards average heading of flockmates"
	cohesionRadius := boidRadius * 35. "steer towards average position of flockmates"

	separationAdjustment := 10. "how far away should Boids stay from each other (smaller further away)"
	alignmentAdjustment := 8. "how aligned the Boids are with each other (smaller more aligned)"
	cohesionAdjustment := 100. "how cohesive the Boids are with each other (smaller more cohesive)"
	
	isCircling := false.
]

{ #category : #accessing }
BoidsSimulation >> isCircling [

	^ isCircling
]

{ #category : #accessing }
BoidsSimulation >> isCircling: aBoolean [

	isCircling := aBoolean
]

{ #category : #moving }
BoidsSimulation >> move [

	boids do: [ :each | each move ]
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsToAlign: aBoid [

	^ self nearbyBoidsWithin: alignmentRadius to: aBoid
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsToCohere: aBoid [

	^ self nearbyBoidsWithin: cohesionRadius to: aBoid
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsToSeparate: aBoid [

	^ self nearbyBoidsWithin: separationRadius to: aBoid
]

{ #category : #'looking at others' }
BoidsSimulation >> nearbyBoidsWithin: aRadius to: aBoid [

	^ boids select: [ :eachBoid | 
		  aBoid isNearby: eachBoid within: aRadius ]
]

{ #category : #private }
BoidsSimulation >> newBoid [

	^ (Boid newIn: self)
		  radius: boidRadius;
		  yourself
]

{ #category : #accessing }
BoidsSimulation >> separationAdjustment [

	^ separationAdjustment
]

{ #category : #accessing }
BoidsSimulation >> separationAdjustment: aNumber [

	separationAdjustment := aNumber
]

{ #category : #accessing }
BoidsSimulation >> separationRadius [

	^ separationRadius
]

{ #category : #accessing }
BoidsSimulation >> separationRadius: aNumber [

	separationRadius := aNumber
]

{ #category : #accessing }
BoidsSimulation >> toggleCircling [
	
	isCircling := isCircling not
]

{ #category : #accessing }
BoidsSimulation >> velocityLimit [

	^ velocityLimit
]

{ #category : #accessing }
BoidsSimulation >> velocityLimit: aNumber [

	velocityLimit := aNumber
]
