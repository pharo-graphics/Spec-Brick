Extension { #name : #BrColumnedModel }

{ #category : #'*Spec-Brick' }
BrColumnedModel >> removeAllColumns [
	
	columns removeAll.
	self dispatchEvent: (BrColumnsChanged new columns: columns)
]
