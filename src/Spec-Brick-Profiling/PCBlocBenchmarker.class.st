Class {
	#name : #PCBlocBenchmarker,
	#superclass : #PCBenchmarker,
	#instVars : [
		'space',
		'random',
		'boundingBox',
		'numberOfCircles',
		'frames'
	],
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #running }
PCBlocBenchmarker >> closeWindow [

	space close.
]

{ #category : #hook }
PCBlocBenchmarker >> currentFrameCount [
	
	^ frames
]

{ #category : #'as yet unclassified' }
PCBlocBenchmarker >> label [

	^ 'Bloc'
]

{ #category : #running }
PCBlocBenchmarker >> openWindow [

	space := BlSpace new
		host: BlMorphicWindowHost new;
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

	frames := 0.
	space addEventHandlerOn: BlSpaceRenderEndEvent do: [ :evt | 
		frames := frames + 1.
	].

	space show.

]
