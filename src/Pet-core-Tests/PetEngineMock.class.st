Class {
	#name : #PetEngineMock,
	#superclass : #PetEngine,
	#category : #'Pet-core-Tests'
}

{ #category : #public }
PetEngineMock >> execute: command with: args [
	"I am used to test the parser"
	command ifEmpty: [ ^ '*' ].
	^ '«' , command , '[' , (args joinUsing: '§') , ']»'
]
