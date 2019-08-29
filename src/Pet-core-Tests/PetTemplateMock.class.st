Class {
	#name : #PetTemplateMock,
	#superclass : #PetTemplateEngine,
	#category : #'Pet-core-Tests'
}

{ #category : #public }
PetTemplateMock >> execute: command with: args [
	command ifEmpty: [ ^ '*' ].
	^ '¬´' , command , '[' , (args joinUsing: '¬ß') , ']¬ª'
]
