Class {
	#name : #SpBrickTableAdapterTest,
	#superclass : #SpBrickListLikeAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #running }
SpBrickTableAdapterTest >> specWidgetClass [

	^ SpTablePresenter
]

{ #category : #tests }
SpBrickTableAdapterTest >> testImageColumn [

	| firstRow |
	specWidget
		items: { #warning };
		addColumn: 
			(SpImageTableColumn
				title: 'Icon'
				evaluated: [:selector |
					Smalltalk ui icons iconNamed: selector ]).

	"Wait that some important things happen in other process"
	0.2 seconds wait.
	
	firstRow := ((brickWidget childNamed: #scrollable) childAt: 1) children.
	
	"There is one cell in one column."
	self assert: firstRow size equals: 1.
	self
		assert: firstRow first background image
		equals: (Smalltalk ui icons iconNamed: #warning).

]

{ #category : #tests }
SpBrickTableAdapterTest >> testStringColumn [

	| firstRow |
	specWidget
		addColumn:
			(SpStringTableColumn
				title: 'hex'
				evaluated: [ :n | n hex ]);
		items: (3 to: 7);
		showColumnHeaders;
		addColumn:
			(SpStringTableColumn
				 title: 'squared'
				 evaluated: [ :n | n squared asString ]).

	"Wait some important things happen in other process"
	0.2 seconds wait.

	firstRow := ((brickWidget childNamed: #scrollable) childAt: 1) children.

	"There are two cells, one for each column."
	self assert: firstRow size equals: 2.
	self assert: firstRow first text asString equals: '16r3'.
	self assert: firstRow second text asString equals: '9'.
	
	self flag: #todo. "Assert on header"
]
