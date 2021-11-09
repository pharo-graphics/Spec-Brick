Class {
	#name : #BlFFILogger,
	#superclass : #BlMeter,
	#instVars : [
		'loggerCopy'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #API }
BlFFILogger >> openUI [

	(TFLMainPresenter on: loggerCopy) openWithSpec
]

{ #category : #API }
BlFFILogger >> startMetering [

	"Ensure prepared"
	TFLCallLogger
		install;
		resetInstance.
	TFLCallLogger instance entryCount: 20000.

	"Really start"
	TFLCallLogger instance start
]

{ #category : #API }
BlFFILogger >> stopMetering [
	"Store a copy of the global logger, and reset it."

	loggerCopy := TFLCallLogger instance copy.

	TFLCallLogger stop; resetInstance.
]
