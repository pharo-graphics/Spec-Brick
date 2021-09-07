Class {
	#name : #SpBrickColumnedList,
	#superclass : #BrList,
	#instVars : [
		'columnedModel'
	],
	#category : #'Spec-Brick-Widgets-ColumnedList'
}

{ #category : #'api - scripting' }
SpBrickColumnedList >> column [
	<return: #BrColumn>

	^ self viewModel column
]

{ #category : #initialization }
SpBrickColumnedList >> defaultListModel [
	^ BrColumnedListModel new
]

{ #category : #initialization }
SpBrickColumnedList >> initialize [
	| listAptitude |
	super initialize.

	listAptitude := BrColumnedListAptitude new.
	listAptitude listElement dataSource: SpBrickColumnedListDataSource new.

	self aptitude: listAptitude + BrGlamorousWithVerticalScrollbarAptitude
]

{ #category : #'as yet unclassified' }
SpBrickColumnedList >> removeAllColumns [
	
	self viewModel removeAllColumns
]

{ #category : #'api - scripting' }
SpBrickColumnedList >> rowStencil: aRowStencil [
	self aptitude rowStencilBuilder: aRowStencil
]
