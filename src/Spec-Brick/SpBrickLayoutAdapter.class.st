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

	^ self newContainerElement
]

{ #category : #factory }
SpBrickLayoutAdapter >> layout: aLayout [

	layout := aLayout
]

{ #category : #'instance creation' }
SpBrickLayoutAdapter >> newContainerElement [

	^ BlElement new
		  background: Color transparent;
		  constraintsDo: [ :c | 
			  c horizontal matchParent.
			  c vertical matchParent ];
		  yourself
]
