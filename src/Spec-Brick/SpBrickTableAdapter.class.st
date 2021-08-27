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

	aSpTableColumn width
		ifNil: [ addedColumn matchParent ]
		ifNotNil: [ addedColumn width: aSpTableColumn width ]
]

{ #category : #'instance creation' }
SpBrickTableAdapter >> buildWidget [

	^ BrColumnedList new
		  rowStencil: self newBrickItem;
		  yourself
]

{ #category : #'instance creation' }
SpBrickTableAdapter >> newBrickItem [
		
	self flag: #todo. "Check this"
	^ SpBrickColumnedListStencilBuilder new
		customBlock: [ :element |
			self presenter contextMenu ifNotNil: [
				element addAptitude: self newContextMenuAptitude ] ];
		yourself

]

{ #category : #'widget creation' }
SpBrickTableAdapter >> subscribeToPresenter [

	super subscribeToPresenter.
	self presenter
		whenColumnsChangedDo: [ self updateColumns ];
		whenShowColumnHeadersChangedDo:[ self updateColumns ]

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
	
	"widget removeAptitude: BrColumnedListHeaderAptitude."
	self flag: #todo. "How to refresh the header?"
	self presenter isShowingColumnHeaders
		ifTrue: [ widget addAptitude: BrColumnedListHeaderAptitude ]
]

{ #category : #visiting }
SpBrickTableAdapter >> visitImageColumn: aSpImageTableColumn [

	^ widget column
		  cellStencil: [
			BlElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				yourself ];
		  dataBinder: [ :aBlElement :eachItem | 
			  | aForm |
			  aForm := aSpImageTableColumn evaluation cull: eachItem.
			  aBlElement
"				  size: aForm extent;"
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
				  aptitude: BrGlamorousListLabelAptitude new;
				  yourself ];
		  dataBinder: [ :aLabel :eachItem | 
			  aLabel text: (aSpStringTableColumn evaluation cull: eachItem) ]
]
