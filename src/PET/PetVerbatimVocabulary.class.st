"
I am a vocabulary wich ignores all commands (actually, I print the command back on output).

I only have one command '!endVerbatim', which pops me, and thereby exits verbatim mode.
"
Class {
	#name : #PetVerbatimVocabulary,
	#superclass : #PetVocabulary,
	#category : #'PET-Text'
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
