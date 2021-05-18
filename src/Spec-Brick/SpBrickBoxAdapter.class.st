Class {
	#name : #SpBrickBoxAdapter,
	#superclass : #SpBrickLayoutAdapter,
	#instVars : [
		'startContainerElement',
		'endContainerElement'
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
		ifTrue: [ startContainerElement addChild: newElement ]
		ifFalse: [ endContainerElement addChild: newElement ].

	^ newElement
]

{ #category : #factory }
SpBrickBoxAdapter >> buildWidget [ 

	startContainerElement := self newContainerElement.
	endContainerElement := self newContainerElement.

	^ super buildWidget
		addChild: startContainerElement;
		addChild: endContainerElement;
		yourself
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

	startContainerElement layout: BlFlowLayout vertical.
	endContainerElement layout: BlFlowLayout vertical.
"			vResizing: #shrinkWrap;
			height: 0;"
						
	widget layout: BlFlowLayout vertical
]
