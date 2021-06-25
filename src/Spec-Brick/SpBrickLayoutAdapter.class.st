"
I'm an adapter for layouts.

See `SpBrickAdapter` for more information.
"
Class {
	#name : #SpBrickLayoutAdapter,
	#superclass : #SpBrickAdapter,
	#instVars : [
		'layout'
	],
	#category : #'Spec-Brick-Adapters'
}

{ #category : #adding }
SpBrickLayoutAdapter >> add: aPresenter constraints: constraints [ 
	"Add a new child to my presenter, and build it following the specified SpLayoutConstraints. 
	
	Inspired on SpMorphicLayoutAdapter>>#add:constraints:"

	| aBlElement |
	aPresenter owner: self presenter. 

	aBlElement := self 
		newChildBlElement: aPresenter
		constrainedBy: constraints.
		
	self addChildElement: aBlElement with: constraints
]

{ #category : #adding }
SpBrickLayoutAdapter >> addChildElement: aBlElement with: constraints [
	"Add a new element as child to the backend widget"

	self subclassResponsibility	
]

{ #category : #'instance creation' }
SpBrickLayoutAdapter >> addConstraints: constraints toChild: childBlElement [
	"Inspired on SpMorphicLayoutAdapter>>#addConstraints:toChild:"

	^ self subclassResponsibility
]

{ #category : #'widget creation' }
SpBrickLayoutAdapter >> buildWidget [
	"Answer nil to postpone instance creation until we know the layout (not enough information at this moment). See #newBrickWidget."

	^ nil
]

{ #category : #building }
SpBrickLayoutAdapter >> buildWithSpec: aString [ 
	"Inspired in SpMorphicLayoutAdapter>>#buildWithSpec"

	^ widget	
]

{ #category : #protocol }
SpBrickLayoutAdapter >> layout: aLayout [

	layout := aLayout.
	widget := self newBrickWidget.
	self updateWidgetFromLayout.
]

{ #category : #'instance creation' }
SpBrickLayoutAdapter >> newBlElementFrom: aPresenter constraints: constraints [ 
	"Inspired on SpMorphicLayoutAdapter>>#buildMorph:constraints:"

	| newElement |
	newElement := aPresenter buildWithSpec: constraints spec.

"	self applyStyle: aPresenter to: childMorph.
	""Add children alignment constraints (if applies)""
	childMorph := self 
		applyChildrenAlignmentTo: childMorph 
		constraints: constraints. 
"	
	newElement := self
		addConstraints: constraints 
		toChild: newElement.

	^ newElement
]

{ #category : #protocol }
SpBrickLayoutAdapter >> newBrickWidget [
	"Answer the new Brick widget, based on the SpExecutableLayout in the slot named #layout."

	^ self subclassResponsibility	
]

{ #category : #adding }
SpBrickLayoutAdapter >> newChildBlElement: aPresenter constrainedBy: constraints [
	"Answer a new Brick widget that corresponds to the received Spec presenter. The answer should follow the specified layout constraints.
	
	Originally inspired on SpMorphicLayoutAdapter>>#basicAdd:constraints:to:"

	^ self subclassResponsibility

]

{ #category : #protocol }
SpBrickLayoutAdapter >> updateWidgetFromLayout [
	"Prepare widget based on layout specifications before adding children."

	self subclassResponsibility	
]
