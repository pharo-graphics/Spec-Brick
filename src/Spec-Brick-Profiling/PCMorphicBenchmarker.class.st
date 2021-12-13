Class {
	#name : #PCMorphicBenchmarker,
	#superclass : #PCBenchmarker,
	#instVars : [
		'window',
		'morph'
	],
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #running }
PCMorphicBenchmarker >> closeWindow [

	window delete

]

{ #category : #hook }
PCMorphicBenchmarker >> currentFrameCount [

	^ morph frameCount
]

{ #category : #printing }
PCMorphicBenchmarker >> label [

	^ 'Athens+Cairo'
]

{ #category : #running }
PCMorphicBenchmarker >> openWindow [
	
	morph := PCTranslatingCirclesMorph new
		numberOfCircles: 50;
		yourself.
	window := morph openInWindow.
	window extent: 500@500.

]
