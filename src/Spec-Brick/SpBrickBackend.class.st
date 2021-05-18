Class {
	#name : #SpBrickBackend,
	#superclass : #SpApplicationBackend,
	#category : #'Spec-Brick'
}

{ #category : #accessing }
SpBrickBackend class >> backendName [

	^ #Brick
]

{ #category : #'deferred message' }
SpBrickBackend >> adapterBindingsClass [

	^ SpBrickAdapterBindings
]

{ #category : #'deferred message' }
SpBrickBackend >> defer: aBlock [

	1halt.
	BlHost pickHost universe defer: aBlock
]
