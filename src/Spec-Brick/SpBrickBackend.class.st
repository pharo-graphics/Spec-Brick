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

{ #category : #accessing }
SpBrickBackend >> defaultConfigurationFor: aSpApplication [

	^ aSpApplication defaultConfigurationForBrick
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

{ #category : #'ui - dialogs' }
SpBrickBackend >> selectFileTitle: aString [

	| answer selectorElement aSpace aSemaphore |
	answer := nil.
	aSemaphore := Semaphore new.

	aSpace := BlSpace new.
	selectorElement := BrFileSelector new 
		okAction: [ :f | answer := f. aSpace close. aSemaphore signal ];
		buttonLabel: 'Select file';
		yourself.

	aSpace addChild: selectorElement; show.

	aSemaphore wait.
	^ answer
]
