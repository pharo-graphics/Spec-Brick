"
I represent a meter in the context of a Bloc profile.

API:
	- startMetering
	- stopMetering

Collaborators:
	- case: the case under study, which may be needed by the meter.
"
Class {
	#name : #BlMeter,
	#superclass : #Object,
	#instVars : [
		'case'
	],
	#category : #'Spec-Brick-Profiling'
}

{ #category : #accessing }
BlMeter >> case [

	^ case
]

{ #category : #accessing }
BlMeter >> case: aCase [

	case := aCase
]

{ #category : #API }
BlMeter >> openUI [

	self subclassResponsibility
]

{ #category : #API }
BlMeter >> startMetering [

	self subclassResponsibility
]

{ #category : #API }
BlMeter >> stopMetering [

	self subclassResponsibility
]
