Class {
	#name : #BlFrameMeter,
	#superclass : #BlMeter,
	#instVars : [
		'process',
		'framesAndMicrosendTimestamps'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #private }
BlFrameMeter >> fpsFrom: frameAndMicrosendTimestampA to: frameAndMicrosendTimestampB [

	| totalSeconds |
	totalSeconds := (Duration microSeconds:
		frameAndMicrosendTimestampB value - frameAndMicrosendTimestampA value) totalSeconds.

	^ (frameAndMicrosendTimestampB key - frameAndMicrosendTimestampA key) / totalSeconds

]

{ #category : #private }
BlFrameMeter >> registerSampleNow [

	framesAndMicrosendTimestamps add:
		case space frame id -> Time microsecondClockValue
]

{ #category : #printing }
BlFrameMeter >> reportAsString [

	^ String streamContents: [ :stream | self reportAsStringOn: stream ]
]

{ #category : #printing }
BlFrameMeter >> reportAsStringOn: stream [

	stream
		<< 'Number of samples:';
		cr;
		tab;
		print: framesAndMicrosendTimestamps size;
		cr.

	framesAndMicrosendTimestamps size >= 1 ifFalse: [ ^ self ].

	stream
		<< 'Frame count:';
		cr;
		tab;
		print: framesAndMicrosendTimestamps last key;
		cr.

	framesAndMicrosendTimestamps size >= 2 ifFalse: [ ^ self ].

	stream
		<< 'Average frequency (frames per second):';
		cr;
		tab;
		<< (self totalFPS printShowingDecimalPlaces: 1);
		<< ' fps';
		cr;
		<< 'Sampled seconds:';
		cr;
		tab;
		print: self totalSeconds asFloat;
		cr.

	framesAndMicrosendTimestamps size > 2 ifFalse: [ ^ self ].

	stream << 'Inter-sample frequency:'; cr.
	framesAndMicrosendTimestamps overlappingPairsWithIndexDo: [ :a :b :index |
		stream
			tab;
			print: index;
			<< '-';
			print: index + 1;
			<< ': ';
			<< ((self fpsFrom: a to: b) printShowingDecimalPlaces: 1);
			<< ' fps';
			cr ]

]

{ #category : #API }
BlFrameMeter >> reportsAsPagesUsing: aBuilder [

	^ { (SpNotebookPage title: 'Frame Report' provider: [ 
		   aBuilder newText
			   text: self reportAsString;
			   yourself ]) }
]

{ #category : #API }
BlFrameMeter >> startMetering [
	"Start a high-priority process that will tally the space's frame id. The id of a space increases on every new frame.
	"

	| delay |
	framesAndMicrosendTimestamps := OrderedCollection new.
	delay := Delay forSeconds: 1.

	[	process := Processor activeProcess.

		[[ process == Processor activeProcess ] whileTrue: [

			"Add a new sample"
			self registerSampleNow.
			
			delay wait.
		]] onErrorDo:[ :e | process := nil. e traceCr ]
	] forkAt: Processor highestPriority - 1

]

{ #category : #API }
BlFrameMeter >> stopMetering [

	process terminate.
	process := nil.
]

{ #category : #accessing }
BlFrameMeter >> totalFPS [

	^ self
		  fpsFrom: framesAndMicrosendTimestamps first
		  to: framesAndMicrosendTimestamps last
]

{ #category : #accessing }
BlFrameMeter >> totalSeconds [
	"Answer the number of elapsed seconds, expressed as a Float."

	^ (Duration microSeconds: framesAndMicrosendTimestamps last value
		   - framesAndMicrosendTimestamps first value) totalSeconds
]
