Class {
	#name : #PetVerbatimVocabulary,
	#superclass : #PetVocabulary,
	#category : #'Pet-core'
}

{ #category : #'as yet unclassified' }
PetVerbatimVocabulary >> endVerbatim: hdr [
	<keywordCommand: 'endVerbatim'>
	engine popVocabulary.
	^''
]

{ #category : #public }
PetVerbatimVocabulary >> unknownCommand: cmd withArgs: args [
	"I did not know how to handle this command. Try next vocabulary"

	| argsExpanded |
	args ifEmpty: [ ^ '!', cmd,' ' ].
	argsExpanded := args joinUsing: '}{'.
	^'!', cmd,'{',argsExpanded,'}'.
	
]
