Class {
	#name : #SpBrickLayoutAdapter,
	#superclass : #SpBrickAdapter,
	#instVars : [
		'layout'
	],
	#category : #'Spec-Brick'
}

{ #category : #factory }
SpBrickLayoutAdapter >> buildWidget [
	"Answer nil to postpone instance creation (not enough information at this moment)."

	^ nil
]

{ #category : #factory }
SpBrickLayoutAdapter >> layout: aLayout [

	layout := aLayout
]
