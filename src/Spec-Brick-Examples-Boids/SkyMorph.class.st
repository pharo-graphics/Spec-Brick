"
I render a bunch of Boids on the sky. I am inspired by AthensDemoMorph.

To see in action, do:
PharoBoids new.
"
Class {
	#name : #SkyMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'flock'
	],
	#category : #'Spec-Brick-Examples-Boids-Morphic'
}

{ #category : #private }
SkyMorph >> addBoids: anInteger [
	"Add a bunch of new boids to the flock."

	anInteger timesRepeat: [flock add: (Boid randomInBounds: self defaultExtent inFlock: flock)].
]

{ #category : #accessing }
SkyMorph >> defaultExtent [
	^ 500@500
]

{ #category : #drawing }
SkyMorph >> drawOn: aCanvas [

	self render.

	aCanvas
		drawImage: surface asForm at: self bounds origin
]

{ #category : #'initialize-release' }
SkyMorph >> initialize [ 
	super initialize.
	self extent: self defaultExtent.
	flock := OrderedCollection new.
	self addBoids: 30.
	surface := AthensCairoSurface extent: self extent.
	self startStepping.
]

{ #category : #drawing }
SkyMorph >> render [ 

	surface drawDuring: [:canvas | 
		surface clear.
		canvas pathTransform loadIdentity.
		canvas setPaint: Color lightGray;
		drawShape: (0@0 corner: self extent).
		flock do: [ :eachBoid | eachBoid drawOn: canvas].
	].

]

{ #category : #stepping }
SkyMorph >> step [
	flock do: [ :eachBoid | eachBoid move].
	self changed
]

{ #category : #stepping }
SkyMorph >> stepTime [
	^ 0
]
