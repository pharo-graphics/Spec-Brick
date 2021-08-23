Class {
	#name : #SpBrickTableAdapter,
	#superclass : #SpBrickListLikeAdapter,
	#category : #'Spec-Brick-Adapters'
}

{ #category : #'widget creation' }
SpBrickTableAdapter >> addColumnFor: aSpTableColumn [

	| addedColumn |
	addedColumn := aSpTableColumn acceptColumnVisitor: self.
	
	addedColumn title: aSpTableColumn title.

	aSpTableColumn isExpandable ifFalse: [
		addedColumn width: aSpTableColumn width ]

]

{ #category : #'instance creation' }
SpBrickTableAdapter >> buildWidget [

	^ BrColumnedList new
rowStencil:
			  BrGlamorousColumnedListSelectableRowElementStencilBuilder new;
				padding: (BlInsets top: 5)
				yourself
]

{ #category : #'widget creation' }
SpBrickTableAdapter >> subscribeToPresenter [

	super subscribeToPresenter.
	self presenter
		whenColumnsChangedDo: [ self updateColumns ]

]

{ #category : #'widget creation' }
SpBrickTableAdapter >> updateAll [

	super updateAll.
	self updateColumns

]

{ #category : #'widget creation' }
SpBrickTableAdapter >> updateColumns [

	widget removeAllColumns.

	self presenter columns do: [ :each |
		self addColumnFor: each ].
]

{ #category : #visiting }
SpBrickTableAdapter >> visitImageColumn: aSpImageTableColumn [

	^ widget column
		  cellStencil: [
			BlElement new
				constraintsDo: [ :c | c horizontal matchParent ];
				yourself ];
		  dataBinder: [ :aBlElement :eachItem | 
			  | aForm |
			  aForm := aSpImageTableColumn evaluation cull: eachItem.
			  aBlElement
				  size: aForm extent;
				  background: aForm ];
		  yourself
]

{ #category : #visiting }
SpBrickTableAdapter >> visitStringColumn: aSpStringTableColumn [

	^ widget column
		  cellStencil: [ 
			  BrLabel new
				  hMatchParent;
				  vFitContent;
				  aptitude: BrGlamorousLabelAptitude new;
				  yourself ];
		  dataBinder: [ :aLabel :eachItem | 
			  aLabel text: (aSpStringTableColumn evaluation cull: eachItem) ]
]
