Extension { #name : #BlElement }

{ #category : #'*Spec-Brick-Examples-Boids' }
BlElement >> boid [

	^ self userData at: #boid
]

{ #category : #'*Spec-Brick-Examples-Boids' }
BlElement >> boid: aBoid [
	self userData at: #boid put: aBoid
]

{ #category : #'*Spec-Brick-Examples-Boids' }
BlElement >> updateFromBoid [

	self transformDo: [ :aBuilder |
		aBuilder rotateBy: self boid velocity degrees.
		aBuilder translateBy: self boid position ]
]
