Class {
	#name : #SpBrickColumnedListDataSource,
	#superclass : #BrColumnedListDataSource,
	#category : #'Spec-Brick-Widgets-ColumnedList'
}

{ #category : #'instance creation' }
SpBrickColumnedListDataSource >> onBindHolder: anElementHolder at: aPosition [

	| anItemObject eachColumnIndex |
	super onBindHolder: anElementHolder at: aPosition.
	
	anItemObject := self rowValues at: aPosition.
	anElementHolder itemElement userData at: #specModel put: anItemObject.

]
