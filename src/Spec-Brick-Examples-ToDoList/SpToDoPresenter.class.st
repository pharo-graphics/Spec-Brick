"
I'm a Spec2 presenter to manage a ToDo list.

The goal is to be an example of use of Spec with Brick as backend, but it should work with other backends, too.

To open with Brick, evaluate:
```
| app model presenter |
app := SpApplication new 
  useBackend: #Brick;
  yourself.

model := SpToDoList exampleWithSomeTasks.
presenter := SpToDoListPresenter newApplication: app model: model.
presenter openWithSpec.
```
"
Class {
	#name : #SpToDoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'listLabel',
		'list',
		'deleteButton',
		'toDoList',
		'toggleCompletedButton',
		'toolbar',
		'statusBar',
		'descriptionLabel',
		'descriptionTextArea'
	],
	#category : #'Spec-Brick-Examples-ToDoList-Presenters'
}

{ #category : #specs }
SpToDoPresenter class >> defaultSpec [

	^ SpBoxLayout newLeftToRight
		  borderWidth: 10;
		  add: (SpBoxLayout newTopToBottom
				   add: #listLabel expand: false;
				   add: #list;
				   add: (SpBoxLayout newLeftToRight
						    add: #toggleCompletedButton;
						    add: #deleteButton;
						    yourself)
				   expand: false;
				   yourself);
		  add: (SpBoxLayout newTopToBottom
				   add: #descriptionLabel expand: false;
				   add: #descriptionTextArea;
				   yourself);
		  yourself
]

{ #category : #actions }
SpToDoPresenter >> completeAllTasks [

	toDoList tasks do: [ :each | each completed: true ]
]

{ #category : #initialization }
SpToDoPresenter >> connectPresenters [

	super connectPresenters.
	
	list whenSelectionChangedDo: [ :aSelection |
		self refreshAccordingToSelectedTask ]
]

{ #category : #actions }
SpToDoPresenter >> deleteAllTasks [

	toDoList deleteAll
]

{ #category : #actions }
SpToDoPresenter >> deleteTask [
	
	toDoList delete: list selectedItem
]

{ #category : #private }
SpToDoPresenter >> iconFor: aToDoTask [ 
	
	| aForm |
	aForm := self iconNamed: #smallOk.

	aToDoTask isCompleted
		ifFalse: [ aForm := aForm dimmed: 0.2 ].
	
	^ aForm
]

{ #category : #initialization }
SpToDoPresenter >> initializePresenters [

	listLabel := self newLabel
		label: 'Tasks:';
		yourself.
	
	list := self newList
		displayIcon: [ :aToDoTask | self iconFor: aToDoTask ];
		display: [ :aToDoTask | aToDoTask title ];
		whenActivatedDo: [ self toggleCompletedTask ];
		yourself.

	descriptionLabel := self newLabel
		label: 'Description:';
		yourself.

	descriptionTextArea := self newText
		disable;
		yourself.
	
	list := self newList
		displayIcon: [ :aToDoTask | self iconFor: aToDoTask ];
		display: [ :aToDoTask | aToDoTask title ];
		whenActivatedDo: [ self toggleCompletedTask ];
		yourself.

	toggleCompletedButton := self newButton
		label: 'Toggle done';
		icon: (self iconNamed: #smallOk);
		action: [ self toggleCompletedTask ];
		yourself.

	deleteButton := self newButton
		label: 'Delete';
		icon: (self iconNamed: #remove);
		action: [ self deleteTask ];
		yourself.

	self initializeToolbar.
	statusBar := self newLabel.

	self refresh.
]

{ #category : #initialization }
SpToDoPresenter >> initializeToolbar [
	
	toolbar := self newToolbar.

	toolbar addItem: (self newToolbarButton
		icon: (self iconNamed: #smallAdd);
		label: 'Create';
		action: [ self openAddTaskDialog ];
		yourself).
	
	toolbar addItemRight: (self newToolbarButton
		icon: (self iconNamed: #smallOk);
		label: 'All done';
		action: [ self completeAllTasks ];
		yourself).
		
	toolbar addItemRight: (self newToolbarButton
		icon: (self iconNamed: #remove);
		label: 'Clean';
		action: [ self deleteAllTasks ];
		yourself).
]

{ #category : #initialization }
SpToDoPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Demo @ ' , aWindowPresenter application backend asString;
		initialExtent: 600 @ 300;
		centered;
		statusBar: statusBar;
		toolbar: toolbar.
]

{ #category : #actions }
SpToDoPresenter >> openAddTaskDialog [

	(SpToDoTaskDialog newApplication: self application model: toDoList)
		parentWindow: self window;
		openDialogWithSpec
]

{ #category : #private }
SpToDoPresenter >> presentersThatRequireTaskSelected [

	^ { deleteButton. toggleCompletedButton }
]

{ #category : #initialization }
SpToDoPresenter >> refresh [ 

	list unselectAll.
	list items: toDoList tasks.
	statusBar label: ('Number of tasks: {1}' format: { toDoList tasks size}).
	self refreshAccordingToSelectedTask.
]

{ #category : #private }
SpToDoPresenter >> refreshAccordingToSelectedTask [

	| hasSelection |
	hasSelection := list selection isEmpty not.

	self refreshDescriptionTextArea.

	self presentersThatRequireTaskSelected do: [ :each | 
		each enabled: hasSelection ]
]

{ #category : #private }
SpToDoPresenter >> refreshDescriptionTextArea [

	| newDescription |
	newDescription := list selectedItem
		                  ifNil: [ '' ]
		                  ifNotNil: [ :selectedTask | 
				                  selectedTask description ].

	descriptionTextArea text: newDescription
]

{ #category : #initialization }
SpToDoPresenter >> setModelBeforeInitialization: aSpToDoList [

	toDoList := aSpToDoList.
	toDoList whenUpdatedSend: #refresh to: self
]

{ #category : #actions }
SpToDoPresenter >> toggleCompletedTask [
	
	| selectedTask |
	selectedTask := list selectedItem.
	selectedTask completed: selectedTask isCompleted not
]
