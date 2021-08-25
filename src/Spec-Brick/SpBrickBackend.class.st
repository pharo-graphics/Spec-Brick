Class {
	#name : #SpBrickBackend,
	#superclass : #SpApplicationBackend,
	#category : #'Spec-Brick-Base'
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

	BlHost pickHost universe defer: aBlock.
	self flag: #todo. "Not tested. Used?" 
	'SpBrickBackend>>defer:' traceCr.
]

{ #category : #printing }
SpBrickBackend >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: Bloc preferableHostClass;
		nextPut: $)

]
