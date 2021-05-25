Class {
	#name : #SpBrickOnMockedHostWindowAdapter,
	#superclass : #SpBrickWindowAdapter,
	#category : #'Spec-Brick-MockedHost'
}

{ #category : #accessing }
SpBrickOnMockedHostWindowAdapter class >> adaptingName [

	^ #WindowAdapter
]

{ #category : #accessing }
SpBrickOnMockedHostWindowAdapter >> blocHost [

	^ BlMockedHost new
]
