"
I represent to most abstract characteristics of the adapters of the Brick backend for Spec2. Given a tree of SpPresenter, each concrete adapter knows what are the BlElements to instantiate, initialize, and do mutual subscriptions to keep them in sync.

The protocol in my hierarchy follows these conventions, grouped by the life-cycle of the presenters:

Widget creation (used in the presenter's build process)
* `adapt:`
* `subscribeToPresenter`
* `subscribeToWidget`

Widget update (used both in presenter's build process, and each time a presenter changes)
* `update*`

Normally, the Brick elements are not ""sync"", in the sense that an update in a property is queued and executed in next UI loop cycle.

"
Class {
	#name : #SpBrickAdapter,
	#superclass : #SpAbstractAdapter,
	#category : #'Spec-Brick-Adapters'
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

{ #category : #accessing }
SpBrickAdapter >> blocHost [

	^ BlHost pickHost
]

{ #category : #private }
SpBrickAdapter >> defer: aBlockClosure [
	"Enqueue aBlockClosure in the BlSpace, which will be valued in next #pulse."

"	| aHost |
	aHost := self blocHost.
	aHost universe pulse.
	aHost universe defer: [ 
		aHost universe pulse.
		aHost universe defer: aBlockClosure.
		aHost universe pulse ].
	aHost universe pulse
"
		self widget enqueueTask: (BlTaskAction new
			 action: aBlockClosure;
			 yourself)
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
	"Apply all the presenter specifications to the backend widget.
	
	Expected to be sent during widget creation."

]
