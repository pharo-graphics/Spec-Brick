Class {
	#name : #SpBrickBoxAdapter,
	#superclass : #SpBrickDirectionableLayoutAdapter,
	#instVars : [
		'startPane',
		'endPane'
	],
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickBoxAdapter >> addChildElement: aBlElement with: aSpBoxConstraints [
	"Add child to the Brick widget. This can be the start or end pane according to constraints's #isPlacedAtStart."

	(aSpBoxConstraints isPlacedAtStart
		ifTrue: [ startPane ]
		ifFalse: [ endPane ]) addChild: aBlElement

]

{ #category : #'widget creation' }
SpBrickBoxAdapter >> addConstraints: aSpBoxConstraints toChild: childBlElement [
	"Inspired on SpMorphicBoxAdapter>>#addConstraints:toChild:"

	layout isHomogeneous 
		ifTrue: [ 1halt. "self addHomogeneousToMorph: childMorph" ].
	
	self updateChildPadding: childBlElement with: aSpBoxConstraints.

	aSpBoxConstraints isExpand 
		ifTrue: [
			self updateAsExpandedChild: childBlElement with: aSpBoxConstraints ]
		ifFalse: [
			self updateAsNonExpandedChild: childBlElement with: aSpBoxConstraints ].
	
	^ childBlElement
]

{ #category : #accessing }
SpBrickBoxAdapter >> endPane [

	^ endPane
]

{ #category : #'widget creation' }
SpBrickBoxAdapter >> newChildBlElement: aPresenter constrainedBy: aSpBoxConstraints [
	"Inspired on SpMorphicBoxAdapter>>#basicAdd:constraints:to:"

	| newElement |
	newElement := self newBlElementFrom: aPresenter constraints: aSpBoxConstraints.	

"	self applyAlignmentToChild: childMorph.
	self verifyBoxExtentOf: aPanel withChild: childMorph.
"
	^ newElement
]

{ #category : #hook }
SpBrickBoxAdapter >> newHorizontal [
	"Configure as horizontal. See #newBrickWidget."

	startPane := self newHorizontalPane.
	endPane := self newHorizontalPane
		hFitContent;
		yourself.

	^ self newHorizontalPane
		  addChild: startPane as: 'boxStart';
		  addChild: endPane as: 'boxEnd';
		  yourself
]

{ #category : #hook }
SpBrickBoxAdapter >> newVertical [
	"Configure as vertical. See #newBrickWidget."

	startPane := self newVerticalPane.
	endPane := self newVerticalPane
		vFitContent;
		yourself.

	^ self newVerticalPane
		  addChild: startPane as: 'boxStart';
		  addChild: endPane as: 'boxEnd';
		  yourself
]

{ #category : #accessing }
SpBrickBoxAdapter >> startPane [

	^ startPane
]

{ #category : #'widget update' }
SpBrickBoxAdapter >> updateAsExpandedChild: childBlElement with: aSpBoxConstraints [
	
	"If is not 'fill', we need to pad it with another (since it 'expands', but does not 'fill')"
	aSpBoxConstraints isFill ifFalse: [ 
		1halt.
		"wrappedChild
			hResizing: #rigid;
			vResizing: #rigid.
		wrappedChild := self newPanel
			addMorphBack: wrappedChild;
			yourself" ]. 
	"Set to fill"
	childBlElement matchParent
]

{ #category : #'widget update' }
SpBrickBoxAdapter >> updateAsNonExpandedChild: childBlElement with: aSpBoxConstraints [
	"Set up child to stay rigid in the layout direction."

	layout direction setRigidityOfNonExpandedBlElement: childBlElement.
	aSpBoxConstraints width ifNotNil: [ :w | 
		1 halt.
		childBlElement width: w ].
	aSpBoxConstraints height ifNotNil: [ :h | 
		1 halt.
		childBlElement height: h ]
]

{ #category : #'widget update' }
SpBrickBoxAdapter >> updateBorderWidth [
	"API: sent from Presenter. See SpBoxLayout>>#borderWidth:"

	widget padding: (BlInsets all: layout borderWidth).
]

{ #category : #'widget update' }
SpBrickBoxAdapter >> updateChildPadding: aBlElement with: aSpBoxConstraints [

	| insets |
	insets := layout direction isHorizontal
		          ifTrue: [ BlInsets horizontal: aSpBoxConstraints padding ]
		          ifFalse: [ BlInsets vertical: aSpBoxConstraints padding ].

	aBlElement padding: insets
]

{ #category : #'widget update' }
SpBrickBoxAdapter >> updateSpacing [
	"API: sent from Presenter. See SpBoxLayout>>#spacing:"

	startPane cellSpacing: layout spacing.
	endPane cellSpacing: layout spacing
]

{ #category : #'widget update' }
SpBrickBoxAdapter >> updateWidgetFromLayout [

	self
		updateBorderWidth;
		updateSpacing.

	layout hasVAlign ifTrue: [
		layout vAlign applyAsBrickVerticalAlignmentOn: widget ].
	layout hasHAlign ifTrue: [
		layout hAlign applyAsBrickHorizontalAlignmentOn: widget ].

]
