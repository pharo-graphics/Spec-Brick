Class {
	#name : #SpBrickBoxAdapter,
	#superclass : #SpBrickLayoutAdapter,
	#instVars : [
		'startPane',
		'endPane'
	],
	#category : #'Spec-Brick'
}

{ #category : #adding }
SpBrickBoxAdapter >> add: aPresenter constraints: constraints [ 

	aPresenter owner: self model. 
	self widgetDo: [ :aPanel |
		self 
			basicAdd: aPresenter
			constraints: constraints 
			to: aPanel ]
]

{ #category : #adding }
SpBrickBoxAdapter >> basicAdd: aPresenter constraints: constraints to: aBlElement [ 

	| newElement |
	newElement := self newElementFrom: aPresenter constraints: constraints.	

"	self applyAlignmentToChild: childMorph.
	self verifyBoxExtentOf: aPanel withChild: childMorph.
"
	constraints isPlacedAtStart
		ifTrue: [ startPane addChild: newElement ]
		ifFalse: [ endPane addChild: newElement ].

	^ newElement
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> layout: aLayout [

	widget := aLayout direction newWidgetOn: self.

	widget padding: (BlInsets all: aLayout borderWidth).

	aLayout hasAlignment 
		ifTrue: [ 1halt. "widget := self applyAlignmentTo: widget" ].

	super layout: aLayout
]

{ #category : #'instance creation' }
SpBrickBoxAdapter >> newElementFrom: aPresenter constraints: constraints [ 

	| newElement |
	newElement := aPresenter buildWithSpec: constraints spec.

"	self applyStyle: aPresenter to: childMorph.
	""Add children alignment constraints (if applies)""
	childMorph := self 
		applyChildrenAlignmentTo: childMorph 
		constraints: constraints. 
	childMorph := self 
		addConstraints: constraints 
		toChild: childMorph.
"	
	^ newElement
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
