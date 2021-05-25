Class {
	#name : #SpBrickLayoutAdapter,
	#superclass : #SpBrickAdapter,
	#instVars : [
		'layout'
	],
	#category : #'Spec-Brick'
}

{ #category : #'widget creation' }
SpBrickLayoutAdapter >> buildWidget [
	"Answer nil to postpone instance creation (not enough information at this moment)."

	^ nil
]

{ #category : #protocol }
SpBrickLayoutAdapter >> layout: aLayout [

	layout := aLayout
]
