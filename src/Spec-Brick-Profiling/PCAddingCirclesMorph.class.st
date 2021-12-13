Class {
	#name : #PCAddingCirclesMorph,
	#superclass : #PCMorph,
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #utilities }
PCAddingCirclesMorph class >> roundedRectanglePathOn: aCanvas [

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
PCAddingCirclesMorph >> drawOnAthensCanvas: aCanvas [

	| transform builder w h x y |
	w := boundingBox width / 2.0.
	h := boundingBox height / 2.0.
	x := random nextInteger: w.
	y := random nextInteger: h.
	transform := AthensCairoTransform for: aCanvas.

	transform save.

	transform translateX: x Y: y.
	aCanvas surface loadSolidColor: (Color random: random).

	builder := AthensCairoPathBuilder new.
	builder context: aCanvas.
	builder
		arcCenterX: 0.0
		centerY: 0.0
		radius: w / 4 * (random next + 0.1)
		startAngle: 0.0
		endAngle: Float pi * 2.
	aCanvas fill.

	transform restore.

]
