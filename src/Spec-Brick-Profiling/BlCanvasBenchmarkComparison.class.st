"
I'm useful to run and report as String the benchmarks defined in TSpartaExamples.

See example in class-side.
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
BlCanvasBenchmarkComparison class >> example [

	self new
		 run;
		 inspect
]

{ #category : #private }
BlCanvasBenchmarkComparison >> benchmarkSelectiorPrefix [

	^ 'benchmark'
]

{ #category : #printing }
BlCanvasBenchmarkComparison >> csvTableString [ 

	^ String streamContents: [:stream | 

		stream << 'bench;Cairo;Skia;ratio'; cr.

		benchSelectors sorted do: [:each |
			| freqOfSkia freqOfCairo |
			freqOfCairo := (results at: { SpartaCairoExamples. each }) first frequency.
			freqOfSkia := (results at: { SkiaCanvasExamples. each }) first frequency.
			stream 
				<< ('{1};{2};{3};{4}' format: {
					each allButFirst: self benchmarkSelectiorPrefix size.
					freqOfCairo printShowingDecimalPlaces: 2.
					freqOfSkia printShowingDecimalPlaces: 2.
					(freqOfCairo / freqOfSkia) printShowingDecimalPlaces: 2.
				}); cr
		]]

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
BlCanvasBenchmarkComparison >> markdownTableString [ 

	^ String streamContents: [:stream | 

		stream
			<< '| bench | Cairo | Skia | ratio |'; cr;
			<< '|:------|-----:|------:|------:|'; cr.

		benchSelectors sorted do: [:each |
			| freqOfSkia freqOfCairo |
			freqOfCairo := (results at: { SpartaCairoExamples. each }) frequency.
			freqOfSkia := (results at: { SkiaCanvasExamples. each }) frequency.
			stream 
				<< ('|{1}|{2}|{3}|{4}|' format: {
					each allButFirst: self benchmarkSelectiorPrefix size.
					freqOfCairo printShowingDecimalPlaces: 2.
					freqOfSkia printShowingDecimalPlaces: 2.
					(freqOfCairo / freqOfSkia) printShowingDecimalPlaces: 2.
				}); cr
		]]

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
