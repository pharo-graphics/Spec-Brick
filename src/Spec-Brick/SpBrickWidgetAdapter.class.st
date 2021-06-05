Class {
	#name : #SpBrickWidgetAdapter,
	#superclass : #SpBrickAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #factory }
SpBrickWidgetAdapter >> buildWidget [

	^ self newBrickWidget
		  aptitude: self initialAptitude;
		  yourself
]

{ #category : #accessing }
SpBrickWidgetAdapter >> enabled: aBoolean [ 

	widget enabled: aBoolean
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

{ #category : #accessing }
SpBrickWidgetAdapter >> updateAll [

	super updateAll.
	self updateEnabled.
]

{ #category : #accessing }
SpBrickWidgetAdapter >> updateEnabled [

	widget enabled: self presenter isEnabled
]
