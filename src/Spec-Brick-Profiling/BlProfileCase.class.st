Class {
	#name : #BlProfileCase,
	#superclass : #Object,
	#instVars : [
		'space',
		'spartaCanvasClass',
		'hostClass'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #initialization }
BlProfileCase >> closeSpace [

	space close
]

{ #category : #hooks }
BlProfileCase >> executeAfterOpen [
]

{ #category : #accessing }
BlProfileCase >> hostClass [

	^ hostClass
]

{ #category : #accessing }
BlProfileCase >> hostClass: aBlHostClass [

	hostClass := aBlHostClass
]

{ #category : #initialization }
BlProfileCase >> initialize [

	super initialize.

	space := BlSpace new
]

{ #category : #hooks }
BlProfileCase >> newElement [
	"Answer the element under study."

	^ self subclassResponsibility
]

{ #category : #initialization }
BlProfileCase >> openSpace [

	self flag: #todo. "Handle Host and SpartaCanvas here? (instead of in runner)"

	space root
		addChild: self newElement;
		forceLayout.
		
	space show.

]

{ #category : #printing }
BlProfileCase >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: hostClass label.
	aStream
		nextPutAll: ', ';
		print: spartaCanvasClass label;
		nextPutAll: ')'.

]

{ #category : #accessing }
BlProfileCase >> space [
	^ space
]

{ #category : #accessing }
BlProfileCase >> spartaCanvasClass [

	^ spartaCanvasClass
]

{ #category : #accessing }
BlProfileCase >> spartaCanvasClass: aSpartaCanvasClass [

	spartaCanvasClass := aSpartaCanvasClass
]
