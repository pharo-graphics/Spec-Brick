Class {
	#name : #SpBrickDirectionableLayoutAdapter,
	#superclass : #SpBrickLayoutAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickDirectionableLayoutAdapter >> newBrickWidget [
	"Create widget via double-dispatch on the direction. See #newHorizontal and #newVertical."

	^ layout direction newWidgetOn: self

]

{ #category : #hook }
SpBrickDirectionableLayoutAdapter >> newHorizontal [
	"Configure as horizontal. See #newBrickWidget."

	^ self subclassResponsibility
]

{ #category : #private }
SpBrickDirectionableLayoutAdapter >> newHorizontalPane [

	^ BrHorizontalPane new
		  matchParent;
		  yourself
]

{ #category : #hook }
SpBrickDirectionableLayoutAdapter >> newVertical [
	"Configure as vertical. See #newBrickWidget."

	^ self subclassResponsibility
]

{ #category : #private }
SpBrickDirectionableLayoutAdapter >> newVerticalPane [

	^ BrVerticalPane new
		  matchParent;
		  yourself
]
