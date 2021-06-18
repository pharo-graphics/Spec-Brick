"
I'm the root element of a BlSpace that represents a SpWindowPresenter.


"
Class {
	#name : #SpBrickWindowElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'menu',
		'toolbar',
		'content',
		'statusBar'
	],
	#category : #'Spec-Brick-Widgets'
}

{ #category : #accessing }
SpBrickWindowElement >> content [

	^ content
]

{ #category : #accessing }
SpBrickWindowElement >> content: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
		
	self replaceChild: content with: aBlElement.
	content := aBlElement
]

{ #category : #initialization }
SpBrickWindowElement >> initialize [

	super initialize.

	self
		layout: BlLinearLayout vertical;
		background: Color white.
		
	menu := self newEmptyElement.
	content := self newEmptyElement.
	statusBar := self newEmptyElement.
	toolbar := self newEmptyElement.
	
	self
		addChild: menu as: #menu;
		addChild: toolbar as: #toolbar;
		addChild: content as: #content;
		addChild: statusBar as: #statusBar.

]

{ #category : #accessing }
SpBrickWindowElement >> menu [

	^ menu
]

{ #category : #accessing }
SpBrickWindowElement >> menu: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	self replaceChild: menu with: aBlElement.
	menu := aBlElement
]

{ #category : #initialization }
SpBrickWindowElement >> newEmptyElement [

	^ BlElement new
		  size: 10 @ 10;
		  yourself
]

{ #category : #accessing }
SpBrickWindowElement >> removeMenu [

	self menu: self newEmptyElement
]

{ #category : #accessing }
SpBrickWindowElement >> removeStatusBar [
	
	self statusBar: self newEmptyElement	
]

{ #category : #accessing }
SpBrickWindowElement >> removeToolbar [

	self toolbar: self newEmptyElement	
]

{ #category : #accessing }
SpBrickWindowElement >> statusBar [

	^ statusBar
]

{ #category : #accessing }
SpBrickWindowElement >> statusBar: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	self replaceChild: statusBar with: aBlElement.
	statusBar := aBlElement.
]

{ #category : #accessing }
SpBrickWindowElement >> toolbar [

	^ toolbar
]

{ #category : #accessing }
SpBrickWindowElement >> toolbar: aBlElement [

	aBlElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].


	self replaceChild: toolbar with: aBlElement.
	toolbar := aBlElement
]
