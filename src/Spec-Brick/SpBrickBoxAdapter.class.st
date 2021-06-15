Class {
	#name : #SpBrickBoxAdapter,
	#superclass : #SpBrickLayoutAdapter,
	#instVars : [
		'startPane',
		'endPane'
	],
	#category : #'Spec-Brick-Adapters'
}

{ #category : #adding }
SpBrickBoxAdapter >> addChildElement: aBlElement with: aSpBoxConstraints [
	"Add child to the Brick widget. This can be the start or end pane according to constraints's #isPlacedAtStart."

	(aSpBoxConstraints isPlacedAtStart
		ifTrue: [ startPane ]
		ifFalse: [ endPane ]) addChild: aBlElement

]

{ #category : #adding }
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

{ #category : #'instance creation' }
SpBrickBoxAdapter >> layout: aSpBoxLayout [

	"Create widget via double-dispatch on the direction. See #newHorizontal and #newVertical."
	widget := aSpBoxLayout direction newWidgetOn: self.

	widget padding: (BlInsets all: aSpBoxLayout borderWidth).

	aSpBoxLayout hasAlignment 
		ifTrue: [ 1halt. "widget := self applyAlignmentTo: widget" ].

	super layout: aSpBoxLayout
]

{ #category : #adding }
SpBrickBoxAdapter >> newChildBlElement: aPresenter constrainedBy: aSpBoxConstraints [
	"Inspired on SpMorphicBoxAdapter>>#basicAdd:constraints:to:"

	| newElement |
	newElement := self newBlElementFrom: aPresenter constraints: aSpBoxConstraints.	

"	self applyAlignmentToChild: childMorph.
	self verifyBoxExtentOf: aPanel withChild: childMorph.
"
	^ newElement
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newHorizontal [
	"Configure as horizontal. See #layout:."

	startPane := self newHorizontalPane.
	endPane := self newHorizontalPane
		hFitContent;
		yourself.

	^ self newHorizontalPane
		  addChild: startPane as: 'boxStart';
		  addChild: endPane as: 'boxEnd';
		  yourself
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newHorizontalPane [

	^ BrHorizontalPane new
		  matchParent;
		  yourself
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newVertical [
	"Configure as vertical. See #layout:."

	startPane := self newVerticalPane.
	endPane := self newVerticalPane
		vFitContent;
		yourself.

	^ self newVerticalPane
		  addChild: startPane as: 'boxStart';
		  addChild: endPane as: 'boxEnd';
		  yourself
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newVerticalPane [

	^ BrVerticalPane new
		  matchParent;
		  yourself
]

{ #category : #adding }
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

{ #category : #adding }
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

{ #category : #'as yet unclassified' }
SpBrickBoxAdapter >> updateChildPadding: aBlElement with: aSpBoxConstraints [

	| insets |
	insets := layout direction isHorizontal
		          ifTrue: [ BlInsets horizontal: aSpBoxConstraints padding ]
		          ifFalse: [ BlInsets vertical: aSpBoxConstraints padding ].

	aBlElement padding: insets
]
