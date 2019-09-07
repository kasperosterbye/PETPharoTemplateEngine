Class {
	#name : #BaselineOfPet,
	#superclass : #BaselineOf,
	#category : #BaselineOfPet
}

{ #category : #accessing }
BaselineOfPet >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Pet-core';
				package: 'Pet-core-Tests' with: [ spec requires: #('Pet-core') ] ].
]

{ #category : #accessing }
BaselineOfPet >> projectClass [
	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfPet >> puGizmoDependency: spec [
	"https://github.com/fuhrmanator/PlantUMLPharoGizmo/tree/master/src"

	spec
		baseline: 'PUGizmo'
		with: [ spec repository: 'github://fuhrmanator/PlantUMLPharoGizmo:master/src' ]
]
