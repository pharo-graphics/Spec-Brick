Class {
	#name : #BlFFICounter,
	#superclass : #BlMeter,
	#instVars : [
		'functionNamesAndCounts'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #API }
BlFFICounter >> reportsAsPagesUsing: aBuilder [

	^ { (SpNotebookPage title: 'FFI Function Name Counts' provider: [ 
		   functionNamesAndCounts inspectionItems: aBuilder ]) }
]

{ #category : #API }
BlFFICounter >> startMetering [

	"Ensure prepared"
	TFLCallLogger install.
	TFLFunctionCounter resetInstance.

	"Really start"
	TFLFunctionCounter start.

]

{ #category : #API }
BlFFICounter >> stopMetering [
	"Extract relevant information of the global logger, and reset it."

	functionNamesAndCounts := TFLFunctionCounter instance functionNamesAndCounts.
	functionNamesAndCounts := OrderedDictionary newFrom: 
		(functionNamesAndCounts associations sorted: [ :a :b | a value > b value ]).

	TFLFunctionCounter stop; resetInstance.
]
