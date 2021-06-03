Class {
	#name : #SpBrickWidgetAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick'
}

{ #category : #hook }
SpBrickWidgetAdapter >> buildWidget [

	^ self newBrickWidget
		  aptitude: self initialAptitude;
		  yourself
]

{ #category : #'widget creation' }
SpBrickWidgetAdapter >> initialAptitude [
	"Answer the BrAptitude to initialize the new Brick widget."

	^ self subclassResponsibility	
]

{ #category : #'widget creation' }
SpBrickWidgetAdapter >> newBrickWidget [
	"Answer the new Brick widget."

	^ self subclassResponsibility	
]
