Extension { #name : #Duration }

{ #category : #'*Spec-Brick-Profiling' }
Duration class >> microSeconds: aNumber [
	"A microsecond is equal to 1000 nanoseconds."

	^ self nanoSeconds: aNumber * 1e3
]
