Class {
	#name : #SpBrickOnMockedHostAdapterBindings,
	#superclass : #SpAdapterBindings,
	#category : #'Spec-Brick-MockedHost'
}

{ #category : #initialize }
SpBrickOnMockedHostAdapterBindings >> abstractAdapterClass [
	"This hook in not needed as afar as allAdapters is overriden (the only sender in the superclass)."

	^ self shouldNotImplement
]

{ #category : #initialize }
SpBrickOnMockedHostAdapterBindings >> allAdapters [
	"Answer the same adapters as SpBrickAdapter with a key substitution."

	| adapters |
	adapters := SpBrickAdapter allAdapters copy.
	adapters
		remove: SpBrickWindowAdapter;
		add: SpBrickOnMockedHostWindowAdapter.

	^ adapters
]
