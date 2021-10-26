Class {
	#name : #BoidsSkyPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'toolbar',
		'skyPresenter',
		'toggleCirclingButton',
		'simulationElement',
		'startButton',
		'stopButton',
		'stepButton'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-Spec'
}

{ #category : #specs }
BoidsSkyPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #skyPresenter;
		yourself
]

{ #category : #examples }
BoidsSkyPresenter class >> exampleBloc1 [

	| app model presenter |
	app := SpApplication new 
		useBackend: #Brick;
		yourself.

	model := BoidsSkyElement exampleElement.
	presenter := self newApplication: app model: model.
	presenter openWithSpec
]

{ #category : #examples }
BoidsSkyPresenter class >> exampleBloc2 [

	| app model presenter |
	app := SpApplication new 
		useBackend: #Brick;
		yourself.

	model := BoidsSkyUsingGeometryElement exampleElement.
	presenter := self newApplication: app model: model.
	presenter openWithSpec
]

{ #category : #initialization }
BoidsSkyPresenter >> doStart [

	simulationElement ensureStepping.
	self refreshToolbar.
]

{ #category : #initialization }
BoidsSkyPresenter >> doStep [

	simulationElement step
	"No need to refresh toolbar in this case"
]

{ #category : #initialization }
BoidsSkyPresenter >> doStop [

	simulationElement ensureNotStepping.
	self refreshToolbar.
]

{ #category : #initialization }
BoidsSkyPresenter >> doToggleCircling [

	simulationElement simulation toggleCircling.
	self refreshToolbar.
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
	self refreshToolbar.
]

{ #category : #initialization }
BoidsSkyPresenter >> initializeToolbar [

	toolbar := self newToolbar.

	toolbar addItem: (stopButton := self newToolbarButton
		action: [ self doStop ];
		label: 'Stop';
		help: 'Freeze the boids' translated;
		icon: (self iconNamed: #testRed);
		yourself).

	toolbar addItem: (startButton := self newToolbarButton
		action: [ self doStart ];
		label: 'Start';
		help: 'Let the boids fly' translated;
		icon: (self iconNamed: #testGreen);
		yourself).

	toolbar addItem: (stepButton := self newToolbarButton
		action: [ self doStep ];
		label: 'Step';
		help: 'Do one step' translated;
		icon: (self iconNamed: #smallRedo); "smallRedo testNotRun"
		yourself).

	toolbar addItem: (toggleCirclingButton := self newToolbarButton
		action: [ self doToggleCircling ];
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
BoidsSkyPresenter >> refreshToolbar [

	startButton enabled: simulationElement isSteppingAnimation not.
	stepButton enabled: simulationElement isSteppingAnimation not.
	stopButton enabled: simulationElement isSteppingAnimation.
	
	toggleCirclingButton label: 
		(simulationElement simulation isCircling
			ifTrue: [ 'Circle' ]
			ifFalse: [ 'Free' ])

]

{ #category : #initialization }
BoidsSkyPresenter >> setModelBeforeInitialization: aSkyElement [

	simulationElement := aSkyElement
]
