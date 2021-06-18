Class {
	#name : #SpBrickWindowAdapter,
	#superclass : #SpBrickWindowLikeAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #hook }
SpBrickWindowAdapter >> newRootElement [

	^ SpBrickWindowElement new
]
