"
Benchmarks to compare Sparta andd Athens-Cairo.


Example of use:
~~~

PCBlocBenchmarker new
	beSkia;
	runInFork.

PCBlocBenchmarker new
	beCairo;
	runInFork.

PCMorphicBenchmarker new
	runInFork.
~~~
"
Class {
	#name : #PCBenchmarker,
	#superclass : #Object,
	#instVars : [
		'loggedFrames',
		'loggedCalls',
		'loggedCallsRanking',
		'numberOfSeconds',
		'loggedSecondCount'
	],
	#category : #'Spec-Brick-Profiling-PlainCairo'
}

{ #category : #running }
PCBenchmarker >> closeWindow [

	self subclassResponsibility
	

]

{ #category : #hook }
PCBenchmarker >> currentFrameCount [

	^ self subclassResponsibility
]

{ #category : #initializing }
PCBenchmarker >> initialize [

	super initialize.
	
	numberOfSeconds := 5.
]

{ #category : #printing }
PCBenchmarker >> label [

	^ self subclassResponsibility
]

{ #category : #running }
PCBenchmarker >> openWindow [
	
	self subclassResponsibility

]

{ #category : #running }
PCBenchmarker >> report [

	^ String streamContents: [ :aStream | self reportOn: aStream ]
]

{ #category : #running }
PCBenchmarker >> reportOn: aStream [

	aStream lf; << self label; lf; lf.

	aStream << 'FPS: '.
	(loggedFrames / numberOfSeconds) printOn: aStream showingDecimalPlaces: 2.
	aStream lf; lf.
	
	aStream << 'Top FFI Calls:'; lf.
	DataFrameMarkdownPrinter new
		stringBlockClosure: [ :o :r :c |
			(c = 2
				ifTrue: [ o printShowingDecimalPlaces: 0 ]
				ifFalse: [ o ]) asString ];
		dataFrame: (loggedCallsRanking head: 15);
		stream: aStream;
		write.

	aStream lf; lf.

]

{ #category : #running }
PCBenchmarker >> reportOnStdout [

	self reportOn: Stdio stdout
]

{ #category : #running }
PCBenchmarker >> run [

	self startLogging.
	self openWindow.
	numberOfSeconds seconds wait.
	self stopLogging.
	self closeWindow.
	self reportOnStdout.
]

{ #category : #running }
PCBenchmarker >> runInFork [

	[ self run ] fork
]

{ #category : #running }
PCBenchmarker >> startLogging [

	"Ensure prepared"
	TFLCallLogger
		install;
		resetInstance.
	TFLCallLogger instance entryCount: 20000.
	TFLFunctionCounter resetInstance.

	"Really start"
	TFLCallLogger instance start.
	TFLFunctionCounter start.

]

{ #category : #running }
PCBenchmarker >> stopLogging [

	| functionNamesSeries countsSeries |
	loggedFrames := self currentFrameCount.
	Halt if: [ loggedFrames isNil ].
	Halt if: [ loggedFrames = 0 ].



	loggedCalls := TFLCallLogger instance copy.
	TFLCallLogger stop; resetInstance.



	loggedCallsRanking := TFLFunctionCounter instance functionNamesAndCounts.
	functionNamesSeries := loggedCallsRanking keys asDataSeries
		name: 'Function names';
		yourself.
	countsSeries := (loggedCallsRanking values
		collect: [ :value | (value / loggedFrames) asFloat ]) asDataSeries
			name: 'Calls per Second';
			yourself.
	loggedCallsRanking := functionNamesSeries asDataFrame
		addColumn: countsSeries;
		sortDescendingBy: countsSeries name;
		yourself.

	TFLFunctionCounter stop; resetInstance.

]
