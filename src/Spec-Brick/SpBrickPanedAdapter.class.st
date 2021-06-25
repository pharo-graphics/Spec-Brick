Class {
	#name : #SpBrickPanedAdapter,
	#superclass : #SpBrickDirectionableLayoutAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #adding }
SpBrickPanedAdapter >> addChildElement: aBlElement with: aSpPanedConstraints [ 

	widget hasChildren 
		ifFalse:  [ 
			| resizer |
			resizer := BlRightResizerElement new.
			resizer attachTo: aBlElement.
			
			aBlElement constraintsDo:[:c |
				c linear weight: layout positionOfSlider ].
			
			widget addChild: aBlElement as: #firstPaned.
			widget addChild: resizer as: #resizer  ]
		ifTrue: [ 
			aBlElement constraintsDo:[:c |
				c linear weight: (1 - layout positionOfSlider) ].

			widget addChild: aBlElement as: #secondPaned ]

]

{ #category : #'instance creation' }
SpBrickPanedAdapter >> addConstraints: aSpPanedConstraints toChild: childBlElement [ 
	"Inspired by SpMorphicPanedAdapter>>#addConstraints:toChild:"

	childBlElement matchParent.

	^ childBlElement
]

{ #category : #adding }
SpBrickPanedAdapter >> newChildBlElement: aPresenter constrainedBy: aSpPanedConstraints [
	"Inspired on SpMorphicPanedAdapter>>#basicAdd:constraints:to:"

	| newElement |
	newElement := self newBlElementFrom: aPresenter constraints: aSpPanedConstraints.	

	self flag: #todo. "Is there something to apply from constraints? #canShrink and #canResize do not have senders!"

	^ newElement
]

{ #category : #hook }
SpBrickPanedAdapter >> newHorizontal [

	^ self newHorizontalPane
]

{ #category : #hook }
SpBrickPanedAdapter >> newVertical [

	^ self newVerticalPane
]

{ #category : #'widget update' }
SpBrickPanedAdapter >> updateWidgetFromLayout [
	"Nothing to do"
]
