"
I am the template expansion engine. My main methods are:

pushVocabulary:
popVocabulary:
and
expand:
"
Class {
	#name : #PetTemplateEngine,
	#superclass : #Object,
	#instVars : [
		'vocStack'
	],
	#category : #'Pet-core'
}

{ #category : #'package access' }
PetTemplateEngine >> execute: command with: args [
	[ ^ vocStack execute: command with: args ]
		on: Error
		do: [ :ex | 
			^ vocStack
				execute: 'error'
				with:
					{command.
					args. ex description} ]
]

{ #category : #public }
PetTemplateEngine >> expand: string [
	^ PetParser new onTemplate: self in: string
]

{ #category : #'package access' }
PetTemplateEngine >> popVocabulary [
	vocStack := vocStack next
]

{ #category : #'package access' }
PetTemplateEngine >> pushVocabulary: voc [
	voc engine: self;next: vocStack.
	vocStack := voc
]

{ #category : #'as yet unclassified' }
PetTemplateEngine >> unknownCommand: cmd withArgs: args [
	^ '[[[ Unknown command: ' , cmd , ' with '
		, args size printString , ' arguments ]]]'
]
