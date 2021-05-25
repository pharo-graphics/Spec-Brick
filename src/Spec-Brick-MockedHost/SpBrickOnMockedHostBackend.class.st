Class {
	#name : #SpBrickOnMockedHostBackend,
	#superclass : #SpApplicationBackend,
	#category : #'Spec-Brick-MockedHost'
}

{ #category : #accessing }
SpBrickOnMockedHostBackend class >> backendName [

	^ #BrickOnMockHost
]

{ #category : #'deferred message' }
SpBrickOnMockedHostBackend >> adapterBindingsClass [

	^ SpBrickOnMockedHostAdapterBindings
]
