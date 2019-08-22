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
	<keywordCommand: 'error'>
	^ '@@@@ ' , cmd ,'/', ((argArray collect: [:a|a printString] ) joinUsing: '§'), ' @@@@'
]

{ #category : #'as yet unclassified' }
PetVocabularyBase >> unknownCommand: cmd withArgs: args [
	^engine unknownCommand: cmd withArgs: args
]
