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
		'commandCache',
		'varargCommands'
	],
	#category : #'PET-Core'
}

{ #category : #commands }
PetVocabulary class >> cacheCommands [
	commandCache := Dictionary new.
	(Pragma allNamed: #keywordCommand: in: self)
		do:
			[ :pragma | commandCache at: pragma arguments first put: pragma method ].
	(Pragma allNamed: #keywordCommand:vararg: in: self)
		do: [ :pragma | 
			commandCache at: pragma arguments first put: pragma method.
			pragma arguments second
				ifTrue: [ varargCommands add: pragma method ] ]
]

{ #category : #compiling }
PetVocabulary class >> compile: text classified: cat withStamp: changeStamp notifying: requestor [
	self resetCache.
	
	^ super
		compile: text
		classified: cat
		withStamp: changeStamp
		notifying: requestor
]

{ #category : #commands }
PetVocabulary class >> findCommand: command [
	commandCache ifNil: [ self cacheCommands ].

	^ commandCache at: command ifAbsent: [ nil ]
]

{ #category : #testing }
PetVocabulary class >> isVarArg: method [
	varargCommands ifNil: [ self resetCache  ].
	^ varargCommands includes: method
]

{ #category : #commands }
PetVocabulary class >> resetCache [
	<script>
	commandCache := nil.
	varargCommands := Set new
]

{ #category : #'as yet unclassified' }
PetVocabulary >> doMethod: method with: args [
	| command |
	(self class isVarArg: method)
		ifFalse: [ method numArgs = args size
				ifTrue: [ ^ method valueWithReceiver: self arguments: args asArray ]
				ifFalse: [ command := (method pragmaAt: #keywordCommand:) arguments first.
	^ ' [ Argument number mismatch in "' , command , '" expected: '
		, method numArgs printString , ' but got: ' , args size printString
		, ' ] ' ] ]
		ifTrue: [ method numArgs = 1
				ifTrue: [ ^ method valueWithReceiver: self arguments: (Array with: args) ]
				ifFalse: [ command := (method pragmaAt: #keywordCommand:vararg: ) arguments first.
	^ ' [ Argument number mismatch in "' , command , '" expected: '
		, method numArgs printString , ' but got: ' , args size printString
		, ' ] ' ] ].
	
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
