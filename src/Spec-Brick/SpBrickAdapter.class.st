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

{ #category : #factory }
SpBrickAdapter >> adapt: aPresenter [

	super adapt: aPresenter.

	self
		updateAll;
		subscribeToModel;
		subscribeToWidget.

]

{ #category : #'deferred message' }
SpBrickAdapter >> defer: aBlockClosure [
	"Enqueue aBlockClosure in the BlSpace, which will be valued in next #pulse."

"	self widget root inUIProcessDo: aBlockClosure."

	self widget enqueueTask: (BlTaskAction new action: aBlockClosure)
]

{ #category : #factory }
SpBrickAdapter >> subscribeToModel [
	"Subscribe to the model so the widget updates on every change announcement."

]

{ #category : #factory }
SpBrickAdapter >> subscribeToWidget [
	"Subscribe to certain widget events that require to trigger actions in the presenter (model)."

]

{ #category : #factory }
SpBrickAdapter >> updateAll [
	"Apply the model' specifications to the backend widget"

]
