"
I provide a SkyMorph with a window and a toolbar.

To see in action, do:
PharoBoids new.
"
Class {
	#name : #PharoBoids,
	#superclass : #Object,
	#instVars : [
		'window',
		'toolbar',
		'sky'
	],
	#category : #'Spec-Brick-Examples-Boids-UI-MorphicAthens'
}

{ #category : #'initialize-release' }
PharoBoids >> initialExtent [
	^ 510@560
]

{ #category : #'initialize-release' }
PharoBoids >> initialize [
	super initialize.
	self installToolbar.
	self installSky.
	self window openInWorld
]

{ #category : #'initialize-release' }
PharoBoids >> installSky [
	self window 
		addMorph: self sky
		fullFrame: (LayoutFrame identity topOffset: self toolbar minExtent y).
]

{ #category : #'initialize-release' }
PharoBoids >> installToolbar [
	self window 
		addMorph: self toolbar
		fullFrame: ((0@0 corner: 1@0) asLayoutFrame bottomOffset: self toolbar minExtent y).
]

{ #category : #accessing }
PharoBoids >> sky [
	^ sky ifNil: [
		sky := SkyMorph new]
]

{ #category : #accessing }
PharoBoids >> toolbar [
	^ toolbar ifNil: [ | tools |
		tools := self window newToolbar: {
			self window 
				newButtonFor: self sky
				getState: nil
				action: #startStepping
				arguments: nil
				getEnabled: nil
				label: 'Start '
				help: 'Let the boids fly' translated. 
			self window 
				newButtonFor: self sky
				getState: nil
				action: #stopStepping
				arguments: nil
				getEnabled: nil
				label: 'Stop '
				help: 'Freeze the boids' translated.
			self window
				newCheckboxFor: Boid
				getSelected: #circling
				setSelected: #toggleCircling
				label: 'Circle around center'
				help: 'toggle circling' translated.
		}.
		toolbar := self window newToolDockingBar addMorph: tools]
]

{ #category : #accessing }
PharoBoids >> window [
 	^ window ifNil: [
		window := StandardWindow labelled: 'PharoBoids'.
		window model: self.
		window announcer
			when: WindowResizing 
			do: [:ann | self sky extent: ann newSize].
		window]
]
