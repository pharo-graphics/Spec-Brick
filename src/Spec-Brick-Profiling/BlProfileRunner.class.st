"
I'm a facade to profile cases.

See my class-side for an example.

"
Class {
	#name : #BlProfileRunner,
	#superclass : #Object,
	#instVars : [
		'case',
		'meters'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #examples }
BlProfileRunner class >> example [

	| hosts canvases cases runners |
	hosts := { BlOSWindowSDL2Host. BlMorphicWindowHost }.
	canvases := { BlSpartaCairoCanvasBuilder. BlSpartaSkiaCanvasBuilder}.
	cases := { BlBoidsProfileCase new. BlTextEditorProfileCase new }.
	runners := hosts flatCollect: [:eachHost |
		canvases flatCollect: [:eachCanvas |
			cases collect: [ :eachCase |
				| case |
				case := eachCase copy
					hostClass: eachHost;
					spartaCanvasClass: eachCanvas;
					yourself.

				(BlProfileRunner newForCase: case)
					enableTelemetry;
					enableFPS;
					enableFFILogger;
					enableASProfiler;
					yourself

				] ] ].

	[	runners do: #runIgnoringOpeningSpace.
		runners do: #openUIs ] fork.

]

{ #category : #'instance creation' }
BlProfileRunner class >> newForCase: aProfileCase [

	^ self new
		  case: aProfileCase;
		  yourself
]

{ #category : #accessing }
BlProfileRunner >> addMeter: aMeter [

	meters add: aMeter
]

{ #category : #accessing }
BlProfileRunner >> case: aProfileCase [ 
	
	case := aProfileCase 
]

{ #category : #convenience }
BlProfileRunner >> enableASProfiler [
	
	self addMeter: BlAndreasSystemProfiler new
]

{ #category : #convenience }
BlProfileRunner >> enableFFILogger [

	self addMeter: BlFFILogger new
]

{ #category : #convenience }
BlProfileRunner >> enableFPS [
	
	self addMeter: BlFrameMeter new
]

{ #category : #convenience }
BlProfileRunner >> enableTelemetry [
	
	self addMeter: BlTelemetryMeter new
]

{ #category : #initialization }
BlProfileRunner >> initialize [

	super initialize.
	
	meters := OrderedCollection new.
]

{ #category : #API }
BlProfileRunner >> openUIs [

	meters do: #openUI

]

{ #category : #printing }
BlProfileRunner >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: case;
		nextPut: $)

]

{ #category : #accessing }
BlProfileRunner >> profilers [

	^ meters
]

{ #category : #accessing }
BlProfileRunner >> profilers: aCollection [

	meters := aCollection
]

{ #category : #running }
BlProfileRunner >> run [

	self withBlocParametersDo: [ 
		self withStartedMetersDo: [ 
			case openSpace.
			[ case executeAfterOpen ] ensure: [ case closeSpace ] ] ]
]

{ #category : #running }
BlProfileRunner >> runIgnoringOpeningSpace [

	self withBlocParametersDo: [ 
		case openSpace.
		self withStartedMetersDo: [ 
			[ case executeAfterOpen ] ensure: [ case closeSpace ] ] ]
]

{ #category : #running }
BlProfileRunner >> withBlocParametersDo: aBlockClosure [

	| systemHostClass systemSpartaCanvas |
"	systemHostClass := Bloc preferableHostClass."
	systemSpartaCanvas := Bloc preferableSpartaCanvas.

"	Bloc preferableHostClass: case hostClass."
	case space host: case hostClass new.
	Bloc preferableSpartaCanvas: case spartaCanvasClass.

	aBlockClosure ensure: [

"		Bloc preferableHostClass: systemHostClass."
		Bloc preferableSpartaCanvas: systemSpartaCanvas.]

]

{ #category : #running }
BlProfileRunner >> withStartedMetersDo: aBlockClosure [

	meters do: [ :each |
		each 
			case: case;
			startMetering ].

	aBlockClosure ensure: [

		meters reverseDo: [ :each |
			each stopMetering ] ]

]
