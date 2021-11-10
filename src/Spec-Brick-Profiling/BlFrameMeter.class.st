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

{ #category : #API }
BlFrameMeter >> openUI [

	UIManager default 
		edit: self reportAsString
		label: 'Frames report'

]

{ #category : #private }
BlFrameMeter >> registerSampleNow [

	framesAndMicrosendTimestamps add:
		case space frame id -> Time microsecondClockValue
]

{ #category : #printing }
BlFrameMeter >> reportAsString [

	^ String streamContents: [ :stream | self reportOn: stream ]
]

{ #category : #printing }
BlFrameMeter >> reportOn: stream [

	stream
		<< 'Number of samples: ';
		print: framesAndMicrosendTimestamps size;
		cr.

	framesAndMicrosendTimestamps size >= 2 ifFalse: [ ^ self ].

	stream
		<< 'Frames per second: ';
		<< (self totalFPS printShowingDecimalPlaces: 1);
		cr;
		<< 'Sampled seconds: ';
		print: self totalSeconds asFloat;
		cr;cr.

	framesAndMicrosendTimestamps size > 2 ifFalse: [ ^ self ].

	stream << 'Detail:'; cr.
	framesAndMicrosendTimestamps overlappingPairsWithIndexDo: [ :a :b :index |
		stream
			print: index;
			<< ': ';
			<< ((self fpsFrom: a to: b) printShowingDecimalPlaces: 1);
			cr ]
]

{ #category : #API }
BlFrameMeter >> reportsAsPagesUsing: aBuilder [

	^ { (SpNotebookPage title: 'FPS' provider: [ 
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
