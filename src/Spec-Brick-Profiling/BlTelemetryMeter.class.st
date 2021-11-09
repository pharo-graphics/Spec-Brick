Class {
	#name : #BlTelemetryMeter,
	#superclass : #BlMeter,
	#instVars : [
		'loggerCopy'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #API }
BlTelemetryMeter >> openUI [

	loggerCopy inspect
]

{ #category : #API }
BlTelemetryMeter >> startMetering [

	BlTelemetryLogger instance
		reset;
		start.

	case space telemetry: BlMemoryTelemetry new
]

{ #category : #API }
BlTelemetryMeter >> stopMetering [

	loggerCopy := BlTelemetryLogger instance copy.

	BlTelemetryLogger instance
		stop;
		reset
]
