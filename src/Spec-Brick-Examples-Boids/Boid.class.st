"
I move at a certain velocity and stay close to my flockmates
- by aligning my speed and direction with theirs (align) and
- by moving closer to them (cohere)
- without bumping into them (separate).

If i fall off one edge of the sky i reappear at the opposite edge (fallthrough).

I can circle around the center of the sky to avoid falling of the edges (circle).

I know how to draw myself on an AthensCanvas.

To see me in action, do:
PharoBoids new.
"
Class {
	#name : #Boid,
	#superclass : #Object,
	#instVars : [
		'position',
		'color',
		'radius',
		'velocity',
		'bounds',
		'flock',
		'delta'
	],
	#classVars : [
		'AlignmentAdjustment',
		'AlignmentRadius',
		'BoidSize',
		'Circling',
		'CohesionAdjustment',
		'CohesionRadius',
		'SeparationAdjustment',
		'SeparationRadius',
		'Speedlimit'
	],
	#category : #'Spec-Brick-Examples-Boids-Model'
}

{ #category : #accessing }
Boid class >> circling [
	^ Circling
]

{ #category : #defaults }
Boid class >> defaultColor [
	^ Color random
]

{ #category : #defaults }
Boid class >> defaultRadius [
	^ 8
]

{ #category : #initialization }
Boid class >> initialize [
	"Boid initialize"
	
	BoidSize := 6.
	Speedlimit := 8.
	
	SeparationRadius := BoidSize * 3. "steer to avoid crowding of flockmates"
	AlignmentRadius := BoidSize * 35. "steer towards average heading of flockmates"
	CohesionRadius := BoidSize * 35. "steer towards average position of flockmates"

	SeparationAdjustment := 10. "how far away should Boids stay from each other (smaller further away)"
	AlignmentAdjustment := 8. "how aligned the Boids are with each other (smaller more aligned)"
	CohesionAdjustment := 100. "how cohesive the Boids are with each other (smaller more cohesive)"
	
	Circling := true.
]

{ #category : #'instance creation' }
Boid class >> randomInBounds: aPoint inFlock: aCollection [
	^ self new
		bounds: aPoint;
		flock: aCollection;
		randomPositionAndVelocity;
		yourself
]

{ #category : #accessing }
Boid class >> toggleCircling [
	Circling := Circling not
]

{ #category : #'flocking rules' }
Boid >> align [
	"Steer towards average heading of flockmates."

	| averageVelocity nearbyBoids |
	nearbyBoids := self selectNearbyBoidsWithin: AlignmentRadius.
	nearbyBoids ifNotEmpty:
		[averageVelocity := (nearbyBoids inject: 0@0 into: [:sum :each | sum + (each velocity)])
		/ (nearbyBoids size).
		delta := delta + ((averageVelocity - self velocity) / AlignmentAdjustment)].
]

{ #category : #accessing }
Boid >> bounds [
	^ bounds
]

{ #category : #accessing }
Boid >> bounds: aPoint [
	bounds := aPoint
]

{ #category : #moving }
Boid >> circle [
	delta := delta - ((self position - (self bounds / 2)) / 200)
]

{ #category : #'flocking rules' }
Boid >> cohere [
	"Steer towards average position of flockmates."

	| averagePosition nearbyBoids |
	nearbyBoids := self selectNearbyBoidsWithin: CohesionRadius.
	nearbyBoids ifNotEmpty:
		[averagePosition := (nearbyBoids inject: 0@0 into: [:sum :each | sum + (each position)]) 
		/ (nearbyBoids size).
		delta := delta + ((averagePosition - self position) / CohesionAdjustment)].
]

{ #category : #accessing }
Boid >> color [
	^color ifNil: [ color := self class defaultColor ].
]

{ #category : #accessing }
Boid >> color: aColor [
	color := aColor.
]

{ #category : #'looking at others' }
Boid >> distanceFrom: aBoid [

	^ self position distanceTo: aBoid position
]

{ #category : #'drawing - Morphic' }
Boid >> drawBallOn: aCanvas [
	"Draw the body of a boid."
	
	| path stroke r |
	r := self radius.	
	
	"Draw a filled ball."
	path := aCanvas createPath: [ :builder | | rNeg halfPi |
		rNeg := r negated.
		halfPi := Float halfPi.  
		
		builder 
			relative;
			moveTo: (self position x - r)@(self position y) + 1;
			cwArcTo: r@rNeg angle: halfPi; 
			cwArcTo: r@r angle: halfPi; 
			cwArcTo: rNeg@r angle: halfPi; 
			cwArcTo: rNeg@rNeg angle: halfPi ].

	aCanvas setPaint: self color.
	aCanvas drawShape: path.	
	
	"Draw the outline of a ball."
	stroke := aCanvas setStrokePaint: self color muchDarker.
	stroke width: 1.
	aCanvas draw.
]

{ #category : #'drawing - Bloc' }
Boid >> drawBallOnSpartaCanvas: aCanvas [
	"Draw the body of a boid."
	
	| aPath |
	aPath := aCanvas shape
		circleAt: self position
		radius: self radius.
		
	aCanvas figure
		path: aPath;
		background: self color;
		border: self color muchDarker;
		width: 1;
		draw

]

{ #category : #'drawing - Morphic' }
Boid >> drawOn: aCanvas [
	self
		drawBallOn: aCanvas;
		drawTailOn: aCanvas

	

]

{ #category : #'drawing - Bloc' }
Boid >> drawOnSpartaCanvas: aCanvas [
	self
		drawBallOnSpartaCanvas: aCanvas;
		drawTailOnSpartaCanvas: aCanvas

	

]

{ #category : #'drawing - Morphic' }
Boid >> drawTailOn: aCanvas [
	"Draw the tail of the boid, that indicates it's speed."
	
	| path |
	path := aCanvas createPath: [:builder |
		builder
			relative;
			moveTo: self position + 1;
			lineTo:  self velocity negated].
	aCanvas drawShape: path.	
]

{ #category : #'drawing - Bloc' }
Boid >> drawTailOnSpartaCanvas: aCanvas [
	"Draw the tail of the boid, that indicates it's speed."

	| aPath |
	aPath := aCanvas shape
		line: self position
		to: self position - self velocity.

	aCanvas figure
		path: aPath;
		border: self color muchDarker;
		width: 1;
		draw

]

{ #category : #moving }
Boid >> fallThrough [
	"If i fall off the edge of the bounds i reappear at the opposite edge.
	At least if the difference does not exceed one time the extent of the bounds"

	((self position x) < 0) ifTrue: [position := position + (bounds x @ 0)].
	((self position x) > bounds x) ifTrue: [position := position - (bounds x @ 0)].
	((self position y) < 0) ifTrue: [position := position + (0 @ bounds y)].
	((self position y) > bounds y) ifTrue: [position := position - (0 @ bounds y)].
]

{ #category : #accessing }
Boid >> flock [
	^ flock
]

{ #category : #accessing }
Boid >> flock: aCollection [
	flock := aCollection
]

{ #category : #'looking at others' }
Boid >> isInFieldOfVision: aBoid [
	| vector1 vector2 cosinusAngle |
	vector1 := self velocity - self position.
	(vector1 = (0@0)) ifTrue: [^ true ].
	vector2 := aBoid position - self position.
	(vector2 = (0@0)) ifTrue: [^ true ].
	cosinusAngle := (vector1 dotProduct: vector2) / ((vector1 r) * (vector2 r)).
	^ (cosinusAngle degreesToRadians) < (0.75 * (Float pi))
]

{ #category : #'looking at others' }
Boid >> isNearby: aBoid within: aThreshold [
	^ aBoid ~~ self and: [(self distanceFrom: aBoid) < aThreshold and: [ self isInFieldOfVision: aBoid ]]
]

{ #category : #moving }
Boid >> move [
	delta := 0@0.
	
	self separate; align; cohere; muffle.
	
	Circling ifTrue: [self circle].
		
	self velocity: velocity + (delta asIntegerPoint).

	self position: position + velocity.
	
	self fallThrough.
]

{ #category : #moving }
Boid >> muffle [
	self velocity r > Speedlimit
		ifFalse: [ ^ self ].
	self velocity: self velocity / self velocity r.
	self velocity: self velocity * Speedlimit
]

{ #category : #accessing }
Boid >> position [
	^ position
]

{ #category : #accessing }
Boid >> position: aPoint [
	position := aPoint
]

{ #category : #printing }
Boid >> printOn: aStream [

	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' position: ';
		print: position.
	aStream
		nextPutAll: ' velocity: ';
		print: velocity
]

{ #category : #accessing }
Boid >> radius [
	^radius ifNil: [ radius := self class defaultRadius ] 
]

{ #category : #accessing }
Boid >> radius: aNumber [
	radius := aNumber
]

{ #category : #private }
Boid >> randomPositionAndVelocity [
	"Give this boid a random position and velocity."

	| maxVelocity |
	maxVelocity := 20.
	position := 
		(bounds x atRandom) @ 
		(bounds y atRandom).

	velocity :=
		(maxVelocity - (2 * maxVelocity) atRandom) @
		(maxVelocity - (2 * maxVelocity) atRandom).
]

{ #category : #'looking at others' }
Boid >> selectNearbyBoidsWithin: aRadius [
	^ flock select: [ :eachBoid | self isNearby: eachBoid within: aRadius]
]

{ #category : #'flocking rules' }
Boid >> separate [
	"Move a bit away from nearby flockmates."

	| distance nearbyBoids |
	distance := 0@0.
	nearbyBoids := self selectNearbyBoidsWithin: SeparationRadius.
	nearbyBoids ifNotEmpty:
		[distance := (nearbyBoids inject: 0@0 into: 
			[:sum :each | sum + ((self position) - (each position)) ] ) ].
	delta := delta + (distance / SeparationAdjustment)
]

{ #category : #accessing }
Boid >> velocity [
	^ velocity ifNil: [ velocity := 0@0 ].
]

{ #category : #accessing }
Boid >> velocity: aPoint [
	velocity := aPoint
]
