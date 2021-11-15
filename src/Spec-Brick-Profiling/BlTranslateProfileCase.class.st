"
I'm a profiling case with a BlElement that translates during a period of time.
"
Class {
	#name : #BlTranslateProfileCase,
	#superclass : #BlSimpleElementProfileCase,
	#category : #'Spec-Brick-Profiling'
}

{ #category : #'instance creation' }
BlTranslateProfileCase >> newSteppingAnimation [

	^ (BlTransformAnimation translate: 0@200)
		  duration: duration;
		  yourself
]
