Class {
	#name : #SpBrickTableAdapterTest,
	#superclass : #SpBrickListLikeAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #tests }
SpBrickTableAdapterTest >> assertHeaderLabels: strings [

	| headerPanes labels |
	self waitBlocSpace.
	headerPanes := brickWidget selectChildrenWithId: #headerPane.
	self assert: headerPanes size equals: 1.
	labels := headerPanes anyOne children collect: [ :each | 
		          each text asString ].
	self assert: labels equals: strings
]

{ #category : #tests }
SpBrickTableAdapterTest >> assertNoHeaderPane [

	| headerPanes |
	self waitBlocSpace.
	headerPanes := brickWidget selectChildrenWithId: #headerPane.
	self assert: headerPanes size equals: 0
]

{ #category : #running }
SpBrickTableAdapterTest >> specWidgetClass [

	^ SpTablePresenter
]

{ #category : #tests }
SpBrickTableAdapterTest >> testColumnHeaders [

	specWidget
		addColumn:
			(SpStringTableColumn
				title: 'string'
				evaluated: [ :n | n asString ]);
		addColumn:
			(SpStringTableColumn
				title: 'hex'
				evaluated: [ :n | n hex ]);
		items: (3 to: 7).
	self assertHeaderLabels: #(string hex).

	specWidget hideColumnHeaders.
	self assertNoHeaderPane.
	
	specWidget showColumnHeaders.
	self assertHeaderLabels: #(string hex).

]

{ #category : #tests }
SpBrickTableAdapterTest >> testColumnUpdate [

	specWidget
		addColumn:
			(SpStringTableColumn
				title: 'string'
				evaluated: [ :n | n asString ]).

	self assertHeaderLabels: #(string).

	specWidget				
		items: (3 to: 7);
		addColumn:
			(SpStringTableColumn
				title: 'hex'
				evaluated: [ :n | n hex ]).
		
	self assertHeaderLabels: #(string hex).
		
	specWidget
		addColumn:
			(SpStringTableColumn
				 title: 'squared'
				 evaluated: [ :n | n squared asString ]).

	self assertHeaderLabels: #(string hex squared).

]

{ #category : #tests }
SpBrickTableAdapterTest >> testImageColumn [

	| cells rows |
	specWidget
		addColumn: 
			(SpImageTableColumn evaluated: [ :selector | 
				Smalltalk ui icons iconNamed: selector ]);
		items: { #warning }.
	self waitBlocSpace.

	rows := (brickWidget childNamed: #scrollable) children.
	self assert: rows size equals: 1.
	cells := rows first children.

	"There is one cell (one column)"
	self assert: cells size equals: 1.
	self
		assert: cells first background image
		equals: (Smalltalk ui icons iconNamed: #warning)
]

{ #category : #tests }
SpBrickTableAdapterTest >> testStringColumn [

	| rows cells |
	specWidget
		addColumn: (SpStringTableColumn evaluated: [ :n | n asString ]);
		items: (3 to: 7).
	self waitBlocSpace.

	rows := (brickWidget childNamed: #scrollable) children.
	self assert: rows size equals: 1.
	cells := rows first children.

	"There is one cell (one column)"
	self assert: cells size equals: 1.
	self assert: cells first text asString equals: '3'.

]
