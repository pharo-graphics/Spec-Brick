"
A SpBrickDropListAdapterTest is a test class for testing the behavior of SpBrickDropListAdapter
"
Class {
	#name : #SpBrickDropListAdapterTest,
	#superclass : #SpBrickWidgetAdapterTest,
	#category : #'Spec-Brick-Tests-Adapters'
}

{ #category : #running }
SpBrickDropListAdapterTest >> specWidgetClass [

	^ SpDropListPresenter
]

{ #category : #tests }
SpBrickDropListAdapterTest >> testDisplay [

	| someItems |
	someItems := $a to: $g.
	specWidget
		display:[:each | each asString, each asString ];
		items: someItems.
	self assert: brickWidget label asString equals: 'aa'.

	self flag: #todo. "See https://github.com/pharo-spec/Spec/issues/1182"
"	specWidget
		display:[:each | each asString ].
	self assert: brickWidget label asString equals: 'a'.
"
]

{ #category : #tests }
SpBrickDropListAdapterTest >> testItems [

	| someItems |
	someItems := $a to: $g.
	specWidget items: someItems.
	self assert: brickWidget label asString equals: 'a'.

]

{ #category : #tests }
SpBrickDropListAdapterTest >> testSelectedIndex [

	| someItems |
	someItems := $a to: $g.
	specWidget
		items: someItems;
		selectIndex: 2.
	self assert: brickWidget label asString equals: 'b'.

]
