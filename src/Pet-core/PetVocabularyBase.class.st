"
I am intended to be the base of the vocabulary stack. My next is nil.
I implement no commands. My unknownCommand:withArgs: command delegates back to the engine.
"
Class {
	#name : #PetVocabularyBase,
	#superclass : #PetVocabulary,
	#category : #'Pet-core'
}

{ #category : #'as yet unclassified' }
PetVocabularyBase >> error: cmd args: argArray [
	"<keywordCommand: 'error'>"
	^ '[[[Error: ' , cmd , '/'
		, ((argArray collect: [ :a | a printString ]) joinUsing: '¬ß')
		, ' ]]]'
]

{ #category : #'as yet unclassified' }
PetVocabularyBase >> error: cmd args: argArray desc: desc [
	<keywordCommand: 'error'>
	^ '[[[Error: ' , cmd , '/'
		, ((argArray collect: [ :a | a printString ]) joinUsing: '¬ß')
		, '"', desc, '" ]]]'
]

{ #category : #'as yet unclassified' }
PetVocabularyBase >> unknownCommand: cmd withArgs: args [
	^engine unknownCommand: cmd withArgs: args
]
