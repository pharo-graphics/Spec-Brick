Class {
	#name : #SpBrickAdapter,
	#superclass : #SpAbstractAdapter,
	#category : #'Spec-Brick'
}

{ #category : #accessing }
SpBrickAdapter class >> adaptingName [
	"Override me if adapter will not follow the common pattern"

	^ (self name withoutPrefix: 'SpBrick') asSymbol
]

{ #category : #initialize }
SpBrickAdapter class >> allAdapters [
	"The abstract adapters should be able to return all the adapters for a framework"
	
	^ self allSubclasses
]

{ #category : #initialization }
SpBrickAdapter >> adapt: aPresenter [

	super adapt: aPresenter.

	self
		updateAll;
		subscribeToPresenter;
		subscribeToWidget.

]

{ #category : #private }
SpBrickAdapter >> defer: aBlockClosure [
	"Enqueue aBlockClosure in the BlSpace, which will be valued in next #pulse."

"	self widget root inUIProcessDo: aBlockClosure."

	self widget enqueueTask: (BlTaskAction new action: aBlockClosure)
]

{ #category : #'widget creation' }
SpBrickAdapter >> subscribeToPresenter [
	"Subscribe to the presenter so the widget updates on every change announcement."

]

{ #category : #'widget creation' }
SpBrickAdapter >> subscribeToWidget [
	"Subscribe to certain widget events that require to trigger actions in the presenter (model).

	Important: avoid cycles in announcements that would produce an infinite loop."

]

{ #category : #'widget update' }
SpBrickAdapter >> updateAll [
	"Apply the presenter specifications to the backend widget"

]
