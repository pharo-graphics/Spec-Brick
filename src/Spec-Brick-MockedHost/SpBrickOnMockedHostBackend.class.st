Class {
	#name : #SpBrickOnMockedHostBackend,
	#superclass : #SpApplicationBackend,
	#category : #'Spec-Brick-MockedHost'
}

{ #category : #accessing }
SpBrickOnMockedHostBackend class >> backendName [

	^ #BrickOnMockedHost
]

{ #category : #'deferred message' }
SpBrickOnMockedHostBackend >> adapterBindingsClass [

	^ SpBrickOnMockedHostAdapterBindings
]
