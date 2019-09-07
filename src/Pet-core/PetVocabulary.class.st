"
I am the abstract root of the pet vocabularies.

I use pragmas to identify which methods are actually commands. 
<arrayCommand> expect an array of arguments
<keywordCommand> expect the arguments to match the keyword

if no matching method is found, the method unknownCommand:withArgs: is called.




"
Class {
	#name : #PetVocabulary,
	#superclass : #Object,
	#instVars : [
		'engine',
		'nextVoc'
	],
	#classInstVars : [
		'commandCache'
	],
	#category : #'Pet-core'
}

{ #category : #'as yet unclassified' }
PetVocabulary class >> cacheCommands [
	self
		commandCache:
			(Dictionary
				newFromPairs:
					((Pragma allNamed: #keywordCommand: in: self)
						collect: [ :p | 
							{p arguments first.
							p method} ]) flattened)
]

{ #category : #accessing }
PetVocabulary class >> commandCache [
	^ commandCache
]

{ #category : #accessing }
PetVocabulary class >> commandCache: anObject [
	commandCache := anObject
]

{ #category : #compiling }
PetVocabulary class >> compile: text classified: cat withStamp: changeStamp notifying: requestor [
	self commandCache: nil.
	^ super
		compile: text
		classified: cat
		withStamp: changeStamp
		notifying: requestor
]

{ #category : #'as yet unclassified' }
PetVocabulary class >> findCommand: command [
	self commandCache ifNil: [ self cacheCommands ].
	^ self commandCache at: command ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
PetVocabulary >> doMethod: method with: args [
	| command |
	method numArgs = args size
		ifTrue: [ ^ method valueWithReceiver: self arguments: args asArray ].
	method numArgs = 1
		ifTrue: [ ^ method valueWithReceiver: self arguments: (Array with: args) ].
	command := (method pragmaAt: #keywordCommand:) arguments first.
	^ ' [ Argument number mismatch in "' , command , '" expected: '
		, method numArgs printString , ' but got: ' , args size printString
		, ' ] '
]

{ #category : #accessing }
PetVocabulary >> engine [
	^ engine
]

{ #category : #accessing }
PetVocabulary >> engine: anObject [
	engine := anObject
]

{ #category : #public }
PetVocabulary >> execute: command with: args [
	| method |
	method := self class findCommand: command.
	method
		ifNotNil: [ ^ self doMethod: method with: args ]
		ifNil: [ ^ self unknownCommand: command withArgs: args ]
]

{ #category : #accessing }
PetVocabulary >> nextVoc [
	^ nextVoc
]

{ #category : #accessing }
PetVocabulary >> nextVoc: voc [
	nextVoc := voc
]

{ #category : #public }
PetVocabulary >> unknownCommand: cmd withArgs: args [
	"I did not know how to handle this command. Try next vocabulary"
	^ nextVoc execute: cmd with: args
]
