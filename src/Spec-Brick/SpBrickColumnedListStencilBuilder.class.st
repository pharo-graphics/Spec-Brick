Class {
	#name : #SpBrickColumnedListStencilBuilder,
	#superclass : #BrGlamorousColumnedListSelectableRowElementStencilBuilder,
	#instVars : [
		'customBlock'
	],
	#category : #'Spec-Brick-Widgets-ColumnedList'
}

{ #category : #'api - instantiation' }
SpBrickColumnedListStencilBuilder >> buildDefault [

	^ super buildDefault
		  in: customBlock;
		  yourself
]

{ #category : #accessing }
SpBrickColumnedListStencilBuilder >> customBlock: anObject [

	customBlock := anObject
]
