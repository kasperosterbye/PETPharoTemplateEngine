"
I am the template expansion engine. My main methods are:

pushVocabulary:
popVocabulary:
and
expand:
"
Class {
	#name : #PetEngine,
	#superclass : #Object,
	#instVars : [
		'vocStack'
	],
	#category : #'Pet-core'
}

{ #category : #'package access' }
PetEngine >> execute: command with: args [
	^[ vocStack execute: command with: args ]
				on: Error
				do: [ :ex | 
					vocStack
						execute: 'error'
						with:
							{command.
							args.
							ex description} ]
]

{ #category : #public }
PetEngine >> expand: string [
	^PetParser new onEngine: self in: string.
]

{ #category : #'package access' }
PetEngine >> nextPut: ch [
	
	vocStack nextPut: ch
]

{ #category : #'package access' }
PetEngine >> nextPutAll: stringOrText [
	vocStack  nextPutAll: stringOrText
]

{ #category : #'package access' }
PetEngine >> popVocabulary [
	vocStack := vocStack nextVoc 
]

{ #category : #'package access' }
PetEngine >> pushVocabulary: voc [
	voc engine: self;nextVoc: vocStack.
	vocStack := voc
]

{ #category : #'package access' }
PetEngine >> unknownCommand: cmd withArgs: args [
	^ '[[[ Unknown command: ' , cmd , ' with '
		, args size printString , ' arguments ]]]'
]
