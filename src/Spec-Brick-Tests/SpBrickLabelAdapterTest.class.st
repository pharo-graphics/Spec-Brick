Class {
	#name : #SpBrickLabelAdapterTest,
	#superclass : #SpBrickAdapterTest,
	#category : #'Spec-Brick-Tests'
}

{ #category : #tests }
SpBrickLabelAdapterTest >> testLabel [

	self
		openPresenter: [ :app | 
			(app new: SpLabelPresenter)
				label: 'Hello Brick';
				yourself ]
		thenDo: [ :aPresenter | 
			self assert: aPresenter label equals: 'Hello Brick' ]
]
