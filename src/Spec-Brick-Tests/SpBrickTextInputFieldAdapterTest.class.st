Class {
	#name : #SpBrickTextInputFieldAdapterTest,
	#superclass : #SpBrickAbstractTextAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #running }
SpBrickTextInputFieldAdapterTest >> specWidgetClass [

	^ SpTextInputFieldPresenter
]

{ #category : #tests }
SpBrickTextInputFieldAdapterTest >> testReturnIsIgnored [

	self simulateKeyPress: BlKeyboardKey return on: brickWidget.
	self assert: brickWidget text asString equals: ''.
	self assert: specWidget text asString equals: ''.

	self simulateKeyPress: BlKeyboardKey a on: brickWidget.
	self simulateKeyPress: BlKeyboardKey return on: brickWidget.
	self simulateKeyPress: BlKeyboardKey b on: brickWidget.
	self waitUI.
	self assert: brickWidget text asString equals: 'ab'.
	self assert: specWidget text asString equals: 'ab'.


]
