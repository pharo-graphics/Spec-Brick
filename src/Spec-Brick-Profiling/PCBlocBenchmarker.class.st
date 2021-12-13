Class {
	#name : #PCBlocBenchmarker,
	#superclass : #PCBenchmarker,
	#instVars : [
		'space',
		'random',
		'boundingBox',
		'numberOfCircles',
		'frames',
		'spartaCanvasBuilderClass',
		'realStartTimestamp'
	],
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #accessing }
PCBlocBenchmarker >> beCairo [
	
	spartaCanvasBuilderClass := BlSpartaCairoCanvasBuilder

]

{ #category : #accessing }
PCBlocBenchmarker >> beSkia [
	
	spartaCanvasBuilderClass := BlSpartaSkiaCanvasBuilder

]

{ #category : #hook }
PCBlocBenchmarker >> closeWindow [

	space close.
]

{ #category : #hook }
PCBlocBenchmarker >> frameCount [
	
	^ frames
]

{ #category : #printing }
PCBlocBenchmarker >> label [

	^ 'Bloc+', spartaCanvasBuilderClass label
]

{ #category : #hook }
PCBlocBenchmarker >> openWindow [

	Bloc preferableSpartaCanvas: spartaCanvasBuilderClass.
	space := BlSpace new
		host: BlMorphicWindowHost new;
		title: self label;
		yourself.
	
	random := Random seed: 1.
	boundingBox := 0@0 extent: 500@500.
	numberOfCircles := 50.

	1 to: numberOfCircles do: [ :index |
		| w circle |
	    w := boundingBox width / 4.0.

		circle := BlElement new
			background: (Color random: random);
			size: 100 asPoint;
			geometry: BlCircleGeometry new;
			relocate: (w + index) @ 150;
			addAnimation: ((BlTransformAnimation translate: 0@200)
			  duration: numberOfSeconds seconds;
			  yourself);
			yourself.

		space addChild: circle.
	].

	space addEventHandlerOn: BlSpaceShownEvent do: [ :evt |
		realStartTimestamp := DateAndTime now
	].
	frames := 0.
	space addEventHandlerOn: BlSpaceRenderEndEvent do: [ :evt | 
		frames := frames + 1.
	].

	space show.

]

{ #category : #hook }
PCBlocBenchmarker >> realStartTimestamp [

	^ realStartTimestamp
]
