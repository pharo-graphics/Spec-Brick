Class {
	#name : #SpToDoTask,
	#superclass : #Object,
	#instVars : [
		'title',
		'completed',
		'toDoList'
	],
	#category : #'Spec-Brick-Examples-ToDoList-Model'
}

{ #category : #'instance creation' }
SpToDoTask class >> titled: aString in: aToDoList [

	^ self basicNew
		  initializeTitle: aString in: aToDoList;
		  yourself
]

{ #category : #accessing }
SpToDoTask >> completed: aBoolean [
	
	completed := aBoolean.
	toDoList 	announceUpdated.
]

{ #category : #initialization }
SpToDoTask >> initializeTitle: aString in: aSpToDoList [ 

	self initialize.
	title := aString.
	toDoList := aSpToDoList.
	completed := false.
]

{ #category : #testing }
SpToDoTask >> isCompleted [
	
	^ completed
]

{ #category : #printing }
SpToDoTask >> printOn: aStream [

	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' title: ';
		print: title.
	aStream
		nextPutAll: ' completed: ';
		print: completed
]

{ #category : #accessing }
SpToDoTask >> title [

	^ title
]

{ #category : #accessing }
SpToDoTask >> title: aString [ 
	
	title := aString.
	toDoList 	announceUpdated.
]

{ #category : #validating }
SpToDoTask >> validate [

	title isEmpty ifTrue: [ 
		SpToDoListValidationError signal: 'Title is empty' ]
]
