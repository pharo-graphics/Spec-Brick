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
presenter := SpToDoPresenter newApplication: app model: model.
presenter openWithSpec.
```
"
Class {
	#name : #SpToDoPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'titleLabel',
		'titleInput',
		'acceptButton',
		'listLabel',
		'list',
		'deleteButton',
		'toDoList',
		'toggleCompletedButton'
	],
	#category : #'Spec-Brick-Examples-ToDoList-Presenters'
}

{ #category : #specs }
SpToDoPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #titleLabel expand: false;
				   add: #titleInput;
				   addLast: #acceptButton;
				   yourself)
		  expand: false;
		  add: #listLabel expand: false;
		  add: #list;
		  add: (SpBoxLayout newLeftToRight
				   add: #toggleCompletedButton;
				   add: #deleteButton)
		  expand: false;
		  yourself
]

{ #category : #actions }
SpToDoPresenter >> acceptTask [

	[ 	toDoList addNewTaskTitled: titleInput text.
		titleInput text: ''.
	]	on: SpToDoListValidationError
		do: [ :error |
			"FIX: how to open a dialog? or show in-situ with a label?" 
			self inform: error messageText ].

	self refresh
]

{ #category : #initialization }
SpToDoPresenter >> connectPresenters [

	super connectPresenters.
	
	list whenSelectionChangedDo: [ :aSelection |
		self refreshAccordingToSelectedTask ]
]

{ #category : #actions }
SpToDoPresenter >> deleteTask [
	
	toDoList delete: list selectedItem.
	self refresh.
]

{ #category : #private }
SpToDoPresenter >> iconFor: aToDoTask [ 
	
	| iconName |
	iconName := aToDoTask isCompleted
		ifTrue:[ #smallOk ]
		ifFalse: [ #blank ].
	
	^ self iconNamed: iconName
]

{ #category : #initialization }
SpToDoPresenter >> initializePresenters [

	titleLabel := self newLabel
		label: 'New Task:';
		yourself.
	
	titleInput := self newTextInput
		placeholder: 'Something to do';
		yourself.

	acceptButton := self newButton
		label: 'Add';
		icon: (self iconNamed: #add);
		action: [ self acceptTask ];
		yourself.

	listLabel := self newLabel
		label: 'Tasks:';
		yourself.
	
	list := self newList
		displayIcon: [ :aToDoTask | self iconFor: aToDoTask ];
		display: [ :aToDoTask | aToDoTask title ];
		whenActivatedDo: [ self toggleCompletedTask ];
		yourself.
	
	toggleCompletedButton := self newButton
		label: 'Toggle completed';
		icon: (self iconNamed: #diff);
		action: [ self toggleCompletedTask ];
		yourself.

	deleteButton := self newButton
		label: 'Delete';
		icon: (self iconNamed: #remove);
		action: [ self deleteTask ];
		yourself.

	self refresh.
]

{ #category : #initialization }
SpToDoPresenter >> initializeWindow: w [

	w title: 'ToDo list in ' , w application backend asString
]

{ #category : #private }
SpToDoPresenter >> presentersThatRequireTaskSelected [

	^ { deleteButton. toggleCompletedButton }
]

{ #category : #initialization }
SpToDoPresenter >> refresh [ 

	list unselectAll.
	list items: toDoList tasks.
	self refreshAccordingToSelectedTask.
]

{ #category : #private }
SpToDoPresenter >> refreshAccordingToSelectedTask [

	| hasSelection |
	hasSelection := list selection isEmpty not.

	self presentersThatRequireTaskSelected do: [ :each | 
		each enabled: hasSelection ]
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