Class {
	#name : #BlSimpleElementProfileCase,
	#superclass : #BlFixedDurationProfileCase,
	#instVars : [
		'element'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #'instance creation' }
BlSimpleElementProfileCase >> newElement [

	^ element := BlElement new
		relocate: 50 asPoint;
		border: (BlBorder paint: Color gray width: 3);
		addAnimation: (self newSteppingAnimation);
		yourself
]

{ #category : #'instance creation' }
BlSimpleElementProfileCase >> newSteppingAnimation [

	| colorGenerator |
	colorGenerator := Generator on: [ :generator | 
		| nextIndex wheel|
		nextIndex := 1.
		wheel := Color wheel: 50.
		[ generator yield: (wheel at: nextIndex).
		nextIndex := (nextIndex + 1) \\ wheel size + 1 ] repeat ].

	^ BlNumberTransition new
		  from: 0;
		  to: 1;
		  onStepDo: [ :t |
			element background: colorGenerator next ];
		  beInfinite;
		  yourself
]
