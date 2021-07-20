Class {
	#name : #SpBrickMenuItemAdapter,
	#superclass : #SpBrickAdapter,
	#instVars : [
		'wrappedButtonPresenter'
	],
	#category : #'Spec-Brick-Adapters'
}

{ #category : #factory }
SpBrickMenuItemAdapter >> buildWidget [

	wrappedButtonPresenter := self presenter newButton.

	^ wrappedButtonPresenter buildWithSpec
]

{ #category : #'widget creation' }
SpBrickMenuItemAdapter >> subscribeToPresenter [

	super subscribeToPresenter.
	self presenter
		whenNameChangedDo: [ self updateName ];
		whenIconChangedDo: [ self updateIcon ]
]

{ #category : #'widget creation' }
SpBrickMenuItemAdapter >> updateAction [

	wrappedButtonPresenter action: self presenter action
]

{ #category : #'widget creation' }
SpBrickMenuItemAdapter >> updateAll [

	super updateAll.

	self
		updateName;
		updateIcon;
		updateAction
]

{ #category : #'widget creation' }
SpBrickMenuItemAdapter >> updateIcon [

	wrappedButtonPresenter icon: self presenter icon
]

{ #category : #'widget creation' }
SpBrickMenuItemAdapter >> updateName [

	wrappedButtonPresenter label: self presenter name
]
