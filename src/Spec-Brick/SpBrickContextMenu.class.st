"
I'm a Brick representation for a SpMenuPresenter.

My items are instances of SpMenuItemPresenter, from which I take the icon, name and action to build Bloc elements.

"
Class {
	#name : #SpBrickContextMenu,
	#superclass : #BrSimpleList,
	#category : #'Spec-Brick-Widgets'
}

{ #category : #initialization }
SpBrickContextMenu >> initialize [

	super initialize.
	self
		fitContent;
		stencil: [ :each | self newStencilFor: each ]
]

{ #category : #initialization }
SpBrickContextMenu >> newStencilFor: aSpMenuItemPresenter [

	| item |
	item := BlElement new
		        viewModel: (BrInteractiveModel new
				         withHover;
				         yourself);
		        aptitude: (BrInteractiveCommonAptitude new
				         default: [ :f | f background: Color transparent ];
				         hovered: [ :f | 
					         f background: BrGlamorousColors defaultButtonBorderColor ];
				         yourself);
		        layout: BlLinearLayout horizontal;
		        constraintsDo: [ :c | 
			        c horizontal matchParent.
			        c vertical fitContent ];
		        padding: (BlInsets all: 5);
		        yourself.

	aSpMenuItemPresenter icon ifNotNil: [ :icon | 
		item addChild: (BlElement new
				 size: 16 asPoint;
				 background: (BlImageBackground image: icon);
				 margin: (BlInsets right: 5);
				 yourself) ].

	aSpMenuItemPresenter name ifNotNil: [ :name | 
		item addChild: (BrLabel new
				 aptitude: BrGlamorousLabelAptitude;
				 text: name;
				 yourself) ].

	aSpMenuItemPresenter action ifNotNil: [ :action | 
		item when: BlClickEvent do: [ 
			action cull: self anchor.
			self anchor dispatchEvent: (BrContextMenuHideWish new
					 anchor: self anchor;
					 yourself) ] ].

	^ item
]
