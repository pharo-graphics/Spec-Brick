"
I'm an example of drawing boids simulation by overriding #drawOnSpartaCanvas:

See an example on class side.
"
Class {
	#name : #BoidsCustomDrawSkyElement,
	#superclass : #BoidsSkyElement,
	#category : #'Spec-Brick-Examples-Boids-UI-Bloc'
}

{ #category : #examples }
BoidsCustomDrawSkyElement class >> exampleOpenInNewSpace [

	^ self new openInNewSpace
]

{ #category : #'drawing - Alexandrie' }
BoidsCustomDrawSkyElement >> aeDrawOn: aeCanvas bodyOf: aBoid [

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: aBoid color ].
	aeCanvas setOutskirtsCentered.
	aeCanvas setBorderBlock: [
		aeCanvas setSourceColor: aBoid color muchDarker.
		aeCanvas setBorderWidth: 1 ].
	aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
		cairoContext
			circleAt: aBoid position
			radius: aBoid radius ].

	aeCanvas drawFigure.

]

{ #category : #'drawing - Alexandrie' }
BoidsCustomDrawSkyElement >> aeDrawOn: aeCanvas velocityOf: aBoid [

	aeCanvas setBackgroundOff.
	aeCanvas setOutskirtsCentered.
	aeCanvas setBorderBlock: [
		aeCanvas setSourceColor: aBoid color muchDarker.
		aeCanvas setBorderWidth: 1 ].
	aeCanvas drawOpenPathWith: [ :cairoContext |
		cairoContext
			moveTo: aBoid position;
			lineRelativeTo: aBoid velocity negated ].

	aeCanvas drawFigure

]

{ #category : #'drawing - Alexandrie' }
BoidsCustomDrawSkyElement >> aeDrawOnlyMeOn: aeCanvas [

	simulation boids do: [ :each |
		aeCanvas restoreContextAfter: [
			self aeDrawOn: aeCanvas bodyOf: each.
			self aeDrawOn: aeCanvas velocityOf: each ] ].

]

{ #category : #initialization }
BoidsCustomDrawSkyElement >> boidWasAddedToSimulation: aBoid [

	self
		invalidate;
		requestLayout
]

{ #category : #'drawing - Sparta' }
BoidsCustomDrawSkyElement >> drawOnSpartaCanvas: aCanvas [

	super drawOnSpartaCanvas: aCanvas.

	simulation boids do: [ :each |
		self
			drawOnSpartaCanvas: aCanvas bodyOf: each;
			drawOnSpartaCanvas: aCanvas velocityOf: each ]

]

{ #category : #'drawing - Sparta' }
BoidsCustomDrawSkyElement >> drawOnSpartaCanvas: aCanvas bodyOf: aBoid [
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

{ #category : #'drawing - Sparta' }
BoidsCustomDrawSkyElement >> drawOnSpartaCanvas: aCanvas velocityOf: aBoid [
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
