Class {
	#name : #PCTranslatingCirclesMorph,
	#superclass : #PCMorph,
	#instVars : [
		'lastMS',
		'numberOfCircles',
		'deltaY'
	],
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #utilities }
PCTranslatingCirclesMorph class >> roundedRectanglePathOn: aCanvas [

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
PCTranslatingCirclesMorph >> drawOnAthensCanvas: aCanvas [

	| transform builder w |

	deltaY
		ifNil: [ deltaY := 0 ]
		ifNotNil:[ deltaY := deltaY + (0.04 * (Time millisecondClockValue - lastMS)) ].
	lastMS := Time millisecondClockValue.

	random := Random seed: 1.

	surface clear: Color white.

	1 to: numberOfCircles do: [ :index |
	    w := boundingBox width / 4.0.
	    transform := AthensCairoTransform for: aCanvas.
	    transform save.
	
	    transform translateX: w + index Y: 150 + deltaY.

	    aCanvas surface loadSolidColor: (Color random: random).

	    builder := AthensCairoPathBuilder new.
	    builder context: aCanvas.
	    builder
	        arcCenterX: 0.0
	        centerY: 0.0
	        radius: 50.0
	        startAngle: 0.0
	        endAngle: Float pi * 2.
	    aCanvas fill.
	    
	    transform restore ]

]

{ #category : #accessing }
PCTranslatingCirclesMorph >> numberOfCircles [

	^ numberOfCircles
]

{ #category : #accessing }
PCTranslatingCirclesMorph >> numberOfCircles: anInteger [

	numberOfCircles := anInteger
]
