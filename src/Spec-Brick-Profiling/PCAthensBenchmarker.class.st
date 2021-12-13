Class {
	#name : #PCAthensBenchmarker,
	#superclass : #PCBenchmarker,
	#instVars : [
		'window',
		'morph'
	],
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #hook }
PCAthensBenchmarker >> closeWindow [

	window delete

]

{ #category : #hook }
PCAthensBenchmarker >> frameCount [

	^ morph frameCount
]

{ #category : #printing }
PCAthensBenchmarker >> label [

	^ 'Athens+Cairo'
]

{ #category : #hook }
PCAthensBenchmarker >> openWindow [
	
	morph := PCTranslatingCirclesMorph new
		numberOfCircles: 50;
		yourself.
	window := morph openInWindowLabeled: self label.
	window extent: 500@500.

]

{ #category : #hook }
PCAthensBenchmarker >> realStartTimestamp [

	^ morph startTimestamp
]
