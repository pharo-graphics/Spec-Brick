Class {
	#name : #SpBrickPanedAdapter,
	#superclass : #SpBrickDirectionableLayoutAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #hook }
SpBrickPanedAdapter >> addChildElement: aBlElement with: aSpPanedConstraints [ 

	widget childrenCount = 1
		ifTrue:  [
			self resizer attachTo: aBlElement.

			aBlElement constraintsDo: [ :c |
				c linear weight: layout positionOfSlider ].
			
			widget addChild: aBlElement at: 1 as: #firstPaned  ]
		ifFalse: [ 
			aBlElement constraintsDo: [ :c |
				c linear weight: (1 - layout positionOfSlider) ].

			widget addChild: aBlElement as: #secondPaned ]

]

{ #category : #hook }
SpBrickPanedAdapter >> addConstraints: aSpPanedConstraints toChild: childBlElement [ 
	"Inspired by SpMorphicPanedAdapter>>#addConstraints:toChild:"

	childBlElement matchParent.

	^ childBlElement
]

{ #category : #private }
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
		  addChild: SpBrickHorizontalResizerElement new as: #resizer;
		  yourself
]

{ #category : #hook }
SpBrickPanedAdapter >> newVertical [

	^ self newVerticalPane
		  addChild: SpBrickVerticalResizerElement new as: #resizer;
		  yourself
]

{ #category : #accessing }
SpBrickPanedAdapter >> resizer [

	^ widget childNamed: #resizer
]

{ #category : #'widget update' }
SpBrickPanedAdapter >> updateWidgetFromLayout [
	"Nothing to do"
]
