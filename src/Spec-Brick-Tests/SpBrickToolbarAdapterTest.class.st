"
A SpBrickToolbarAdapterTest is a test class for testing the behavior of SpBrickToolbarAdapter
"
Class {
	#name : #SpBrickToolbarAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #tests }
SpBrickToolbarAdapterTest >> newToolbarItemForTesting [

	^ specWidget newToolbarButton
		  label: 'Test';
		  action: [  ];
		  yourself
]

{ #category : #running }
SpBrickToolbarAdapterTest >> specWidgetClass [

	^ SpToolbarPresenter
]

{ #category : #tests }
SpBrickToolbarAdapterTest >> testAddItem [

	specWidget addItem: self newToolbarItemForTesting.
	self assert: brickWidget leftItems size equals: 1.
	
	specWidget addItem: self newToolbarItemForTesting.
	self assert: brickWidget leftItems size equals: 2.

	self assertEmpty: brickWidget rightItems.

]

{ #category : #tests }
SpBrickToolbarAdapterTest >> testAddItemRight [

	specWidget addItemRight: self newToolbarItemForTesting.
	self assert: brickWidget rightItems size equals: 1.

	specWidget addItemRight: self newToolbarItemForTesting.
	self assert: brickWidget rightItems size equals: 2.

	self assertEmpty: brickWidget leftItems.

]

{ #category : #tests }
SpBrickToolbarAdapterTest >> testEmpty [

	self assertEmpty: brickWidget leftItems.
	self assertEmpty: brickWidget rightItems.
]
