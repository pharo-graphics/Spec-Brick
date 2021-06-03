Class {
	#name : #SpToDoList,
	#superclass : #Object,
	#instVars : [
		'tasks',
		'announcer'
	],
	#category : #'Spec-Brick-Examples-ToDoList-Model'
}

{ #category : #examples }
SpToDoList class >> exampleWithSomeTasks [

	^ self new
		  addNewTaskTitled: 'Create example';
		  addNewTaskTitled: 'Commit it';
		  addNewTaskTitled: 'Push to repository';
		  yourself
]

{ #category : #accessing }
SpToDoList >> addNewTaskTitled: aString [ 

	| newTask |
	newTask := SpToDoTask titled: aString in: self.
	newTask validate.

	tasks add: newTask.
	self announceUpdated.
]

{ #category : #announcements }
SpToDoList >> announceUpdated [

	announcer announce: SpToDoListUpdated
]

{ #category : #announcements }
SpToDoList >> announcer [

	^ announcer
]

{ #category : #accessing }
SpToDoList >> delete: aToDoTask [ 
	
	tasks remove: aToDoTask.
	self announceUpdated.
]

{ #category : #initialization }
SpToDoList >> initialize [ 

	super initialize.
	tasks := OrderedCollection new.
	announcer := Announcer new.
]

{ #category : #accessing }
SpToDoList >> tasks [

^ tasks	
]

{ #category : #announcements }
SpToDoList >> whenUpdatedSend: aSelector to: aSubscriber [

	announcer weak
		when: SpToDoListUpdated
		send: aSelector
		to: aSubscriber
]
