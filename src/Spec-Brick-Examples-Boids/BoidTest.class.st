"
A BoidTest is a test class for testing the behavior of Boid
"
Class {
	#name : #BoidTest,
	#superclass : #TestCase,
	#instVars : [
		'boid'
	],
	#category : #'Spec-Brick-Examples-Boids-Tests'
}

{ #category : #running }
BoidTest >> setUp [
	boid := Boid new
		color: Color orange;
		position: 30@30;
		radius: 10;
		velocity: 10@10;
		bounds: 100@100;
		yourself
]

{ #category : #'tests-moving' }
BoidTest >> testFallThrough [
	boid bounds: 100@100.
	
	boid position: (-10@ -10).
	boid fallThrough.
	self assert: (boid position = (90@90)).
	
	boid position: 110@110.
	boid fallThrough.
	self assert: (boid position = (10@10)).
]
