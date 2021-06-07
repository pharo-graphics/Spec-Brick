Extension { #name : #BlInsets }

{ #category : #'*Spec-Brick' }
BlInsets class >> horizontal: aNumber [

	^ self left: aNumber right: aNumber
]

{ #category : #'*Spec-Brick' }
BlInsets class >> vertical: aNumber [

	^ self top: aNumber bottom: aNumber
]
