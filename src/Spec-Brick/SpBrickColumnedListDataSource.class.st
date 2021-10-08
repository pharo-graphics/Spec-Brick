Class {
	#name : #SpBrickColumnedListDataSource,
	#superclass : #BrColumnedListDataSource,
	#category : #'Spec-Brick-Widgets-ColumnedList'
}

{ #category : #'instance creation' }
SpBrickColumnedListDataSource >> onBindHolder: anElementHolder at: aPosition [

	| anItemObject |
	super onBindHolder: anElementHolder at: aPosition.
	
	anItemObject := self listModel itemAt: aPosition.
	anElementHolder itemElement userData at: #specModel put: anItemObject.

]
