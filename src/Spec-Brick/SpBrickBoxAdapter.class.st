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
SpBrickBoxAdapter >> addConstraints: constraints toChild: childBlElement [
	"Inspired on SpMorphicBoxAdapter>>#addConstraints:toChild:"

	| wrappedChild |
"	layout isHomogeneous 
		ifTrue: [ self addHomogeneousToMorph: childMorph ].
	wrappedChild := self addPadding: constraints padding toMorph: childMorph.
"	
	wrappedChild := childBlElement.

	constraints isExpand 
		ifTrue: [ 
			"If is not 'fill', we need to pad it with another (since it 'expands', but does not 'fill')"
			constraints isFill ifFalse: [ 
				1halt.
				"wrappedChild
					hResizing: #rigid;
					vResizing: #rigid.
				wrappedChild := self newPanel
					addMorphBack: wrappedChild;
					yourself" ]. 
			"Set to fill"
			wrappedChild matchParent ]
		ifFalse: [
			"It should stay rigid in the layout direction"
			layout direction setRigidityOfNonExpandedBlElement: wrappedChild.
			constraints width ifNotNil: [ :w | 1halt. wrappedChild width: w ].
			constraints height ifNotNil: [ :h | 1halt. wrappedChild height: h ] ].
	
	^ wrappedChild 
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> layout: aLayout [

	widget := aLayout direction newWidgetOn: self.

	widget padding: (BlInsets all: aLayout borderWidth).

	aLayout hasAlignment 
		ifTrue: [ 1halt. "widget := self applyAlignmentTo: widget" ].

	super layout: aLayout
]

{ #category : #adding }
SpBrickBoxAdapter >> newChildBlElement: aPresenter constrainedBy: constraints [
	"Inspired on SpMorphicBoxAdapter>>#basicAdd:constraints:to:"

	| newElement |
	newElement := self newBlElementFrom: aPresenter constraints: constraints.	

"	self applyAlignmentToChild: childMorph.
	self verifyBoxExtentOf: aPanel withChild: childMorph.
"
	constraints isPlacedAtStart
		ifTrue: [ startPane addChild: newElement ]
		ifFalse: [ endPane addChild: newElement ].

	^ newElement
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newHorizontal [

	startPane := self newHorizontalPane.
	endPane := self newHorizontalPane
		hFitContent;
		yourself.

	^ self newHorizontalPane
		  addChild: startPane as: 'boxStartPane';
		  addChild: endPane as: 'boxEndPane';
		  yourself
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newHorizontalPane [

	^ BrHorizontalPane new
		  background: Color white;
		  matchParent;
		  yourself
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newVertical [

	startPane := self newVerticalPane.
	endPane := self newVerticalPane
		vFitContent;
		yourself.

	^ self newVerticalPane
		  addChild: startPane as: 'boxStartPane';
		  addChild: endPane as: 'boxEndPane';
		  yourself
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newVerticalPane [

	^ BrVerticalPane new
		  background: Color white;
		  matchParent;
		  yourself
]
