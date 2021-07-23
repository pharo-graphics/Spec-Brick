Class {
	#name : #BoidsSkyPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'toolbar',
		'skyPresenter',
		'toggleCirclingButton',
		'simulationElement'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-SpecBloc'
}

{ #category : #specs }
BoidsSkyPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #skyPresenter;
		yourself
]

{ #category : #examples }
BoidsSkyPresenter class >> exampleWithManyBoids [

	| app model presenter |
	app := SpApplication new 
		useBackend: #Brick;
		yourself.

	model := BoidsSkyElement exampleWithManyBoids.
	presenter := self newApplication: app model: model.
	presenter openWithSpec
]

{ #category : #initialization }
BoidsSkyPresenter >> initializePresenters [

	super initializePresenters.

	skyPresenter := self instantiate: SpBlElementPresenter.

	simulationElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	skyPresenter element: simulationElement.
	
	self initializeToolbar.
]

{ #category : #initialization }
BoidsSkyPresenter >> initializeToolbar [

	toolbar := self newToolbar.

	toolbar addItem: (self newToolbarButton
		action: [ simulationElement ensureStepping ];
		label: 'Start';
		help: 'Let the boids fly' translated;
		icon: (self iconNamed: #testGreen);
		yourself).

	toolbar addItem: (self newToolbarButton
		action: [ simulationElement ensureNotStepping ];
		label: 'Stop';
		help: 'Freeze the boids' translated;
		icon: (self iconNamed: #testRed);
		yourself).

	toolbar addItem: (self newToolbarButton
		action: [ simulationElement simulation toggleCircling ];
		label: 'Circle?';
		help: 'Toggle circling' translated;
		icon: (self iconNamed: #smallUpdate);
		yourself).

]

{ #category : #initialization }
BoidsSkyPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		centered;
		title: 'Boids';
		initialExtent: 510@560;
		toolbar: toolbar.
]

{ #category : #initialization }
BoidsSkyPresenter >> setModelBeforeInitialization: aSkyElement [

	simulationElement := aSkyElement
]
