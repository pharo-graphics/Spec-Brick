"
Profiling case where Boids example is shown in a space during some seconds.
"
Class {
	#name : #BlBoidsProfileCase,
	#superclass : #BlProfileCase,
	#instVars : [
		'duration'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #accessing }
BlBoidsProfileCase >> duration [

	^ duration ifNil: [ duration := 10 seconds ]
]

{ #category : #accessing }
BlBoidsProfileCase >> duration: anObject [

	duration := anObject
]

{ #category : #hooks }
BlBoidsProfileCase >> executeBody [

	self duration wait
]

{ #category : #hooks }
BlBoidsProfileCase >> newElement [

	^ BoidsSkyElement exampleElement
]