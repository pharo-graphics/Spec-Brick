Class {
	#name : #SpBrickToolbarElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'leftPane',
		'rightPane'
	],
	#category : #'Spec-Brick-Widgets'
}

{ #category : #accessing }
SpBrickToolbarElement >> addItemLeft: aBlElement [

	leftPane addChild: aBlElement
]

{ #category : #accessing }
SpBrickToolbarElement >> addItemRight: aBlElement [

	rightPane addChild: aBlElement
]

{ #category : #initialization }
SpBrickToolbarElement >> initialize [

	super initialize.

	self
		vFitContent;
		hMatchParent.

"	leftPane := BrToolbar new
		            matchParent;
		            yourself.
"	leftPane := BrHorizontalPane new
						hMatchParent;
		            vFitContent;
		            yourself.

"	rightPane := BrToolbar new
		             vMatchParent;
		             hFitContent;
		             yourself.
"
	rightPane := BrHorizontalPane new
		             fitContent;
		             yourself.


	self
		addChild: leftPane as: 'left';
		addChild: rightPane as: 'right'
]

{ #category : #accessing }
SpBrickToolbarElement >> leftItems [

	^ leftPane children
]

{ #category : #accessing }
SpBrickToolbarElement >> removeAllItems [

	leftPane removeChildren.
	rightPane removeChildren.
]

{ #category : #accessing }
SpBrickToolbarElement >> rightItems [

	^ rightPane children
]
