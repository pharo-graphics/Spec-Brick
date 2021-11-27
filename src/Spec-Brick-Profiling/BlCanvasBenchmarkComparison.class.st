"
I'm useful to run and report as String the benchmarks defined in TSpartaExamples.

See examples in class-side.
"
Class {
	#name : #BlCanvasBenchmarkComparison,
	#superclass : #Object,
	#instVars : [
		'results',
		'canvasExamplesClasses',
		'benchSelectors'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #examples }
BlCanvasBenchmarkComparison class >> exampleInspect [

	self new
		 run;
		 inspect
]

{ #category : #examples }
BlCanvasBenchmarkComparison class >> exampleToStdout [

	DataFrameMarkdownPrinter new
		stream: Stdio stdout;
		dataFrame: (BlCanvasBenchmarkComparison new run; asDataFrame);
		write

]

{ #category : #printing }
BlCanvasBenchmarkComparison >> asDataFrame [

	| df benchLabels |
	benchLabels := benchSelectors sorted collect: [ :each | self labelForBenchSelector: each ].

	df := DataFrame
		withRowNames: benchLabels
		columnNames: #(Cairo Skia ratio).
"		columnNames: (#(bench), (canvasExamplesClasses collect: [ :each | each label ]), #(ratio))."
	benchSelectors sorted doWithIndex: [:each :index |
		| freqOfSkia freqOfCairo |
		freqOfCairo := (results at: { SpartaCairoExamples. each }) first frequency.
		freqOfSkia := (results at: { SkiaCanvasExamples. each }) first frequency.
		df
			rowAt: index 
			put: {
				freqOfCairo printShowingDecimalPlaces: 2.
				freqOfSkia printShowingDecimalPlaces: 2.
				(freqOfCairo / freqOfSkia) printShowingDecimalPlaces: 2 } ].

	^ df 

]

{ #category : #private }
BlCanvasBenchmarkComparison >> benchmarkSelectiorPrefix [

	^ 'benchmark'
]

{ #category : #initialization }
BlCanvasBenchmarkComparison >> initialize [

	super initialize.
	
	canvasExamplesClasses := TSpartaExamples users sorted: [:a :b | a name < b name ].

	benchSelectors := TSpartaExamples selectors
		select: [:each | each beginsWith: self benchmarkSelectiorPrefix ].

	"Error in Cairo"
	benchSelectors := benchSelectors copyWithout: #benchmarkFillRectangleWithForm.


]

{ #category : #'as yet unclassified' }
BlCanvasBenchmarkComparison >> inspectorForResultingCanvasIn: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Resulting Canvas'>

	results ifNil: [ ^ aBuilder newNullPresenter ].
	
	^ aBuilder newTable 
		items: benchSelectors;
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each allButFirst: self benchmarkSelectiorPrefix size ])
			beNotExpandable;
			yourself);
		addColumn: (SpImageTableColumn
			title: 'Cairo'
			evaluated: [ :each | (results at: { SpartaCairoExamples. each }) second asMorph ]);
		addColumn: (SpImageTableColumn
			title: 'Skia'
			evaluated: [ :each | (results at: { SkiaCanvasExamples. each }) second asMorph ]);
		yourself
]

{ #category : #printing }
BlCanvasBenchmarkComparison >> labelForBenchSelector: aBenchmarkSelector [

	^ aBenchmarkSelector allButFirst: self benchmarkSelectiorPrefix size
]

{ #category : #running }
BlCanvasBenchmarkComparison >> run [

	results := OrderedDictionary new.
	canvasExamplesClasses do: [ :canvasExamplesClass |
		benchSelectors do: [ :selector |
			results
				at: { canvasExamplesClass. selector }
				put: (canvasExamplesClass new perform: selector) ] ]

]
