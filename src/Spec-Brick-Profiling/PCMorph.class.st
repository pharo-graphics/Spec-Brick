"
I'm a Morph that draws an Athens Canvas every time the World steps.

This is useful for benchmarking FPS.
"
Class {
	#name : #PCMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'frameCount',
		'boundingBox',
		'random',
		'startTimestamp'
	],
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #utilities }
PCMorph class >> roundedRectanglePathOn: aCanvas [

	^ aCanvas createPath: [:builder |
		builder
			absolute;
			moveTo: 70@100;
			lineTo: 330@100;
			cwArcTo: 350@120 angle: 90 degreesToRadians;
			lineTo: 350@280;
			cwArcTo: 330@300 angle: 90 degreesToRadians;
			lineTo: 70@300;
			cwArcTo: 50@280 angle: 90 degreesToRadians;
			lineTo: 50@120;
			cwArcTo: 70@100 angle: 90 degreesToRadians ]


]

{ #category : #drawing }
PCMorph >> drawOn: aMorphicCanvas [

	startTimestamp ifNil: [
		startTimestamp := DateAndTime now ].

	surface drawDuring: [ :aCanvas | self drawOnAthensCanvas: aCanvas ].

	surface displayOnMorphicCanvas: aMorphicCanvas at: bounds origin
]

{ #category : #accessing }
PCMorph >> frameCount [

	^ frameCount
]

{ #category : #initialization }
PCMorph >> initialize [

	super initialize.
	boundingBox := 0@0 extent: 500@500.
	surface := AthensCairoSurface extent: boundingBox extent.

	random := Random seed: 1.
	frameCount := 0.
]

{ #category : #accessing }
PCMorph >> startTimestamp [

	^ startTimestamp
]

{ #category : #stepping }
PCMorph >> step [

	frameCount := frameCount + 1.
	self changed
]

{ #category : #stepping }
PCMorph >> stepTime [

	^ 0
]

{ #category : #accessing }
PCMorph >> surface [

	^ surface
]
