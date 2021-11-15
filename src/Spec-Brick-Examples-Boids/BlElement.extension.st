Extension { #name : #BlElement }

{ #category : #'*Spec-Brick-Examples-Boids' }
BlElement >> boid [

	^ self userData at: #boid
]

{ #category : #'*Spec-Brick-Examples-Boids' }
BlElement >> boid: aBoid [
	self userData at: #boid put: aBoid
]
