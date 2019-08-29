Class {
	#name : #PetTestVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'color'
	],
	#category : #'Pet-core'
}

{ #category : #asserting }
PetTestVocabulary >> assert: res equals: expected [
	color := res = expected
		ifTrue: [ Color r: 0 g: 0.5 b: 0.1 ]
		ifFalse: [ Color r: 0.7 g: 0.7 b: 0 ]
]

{ #category : #tests }
PetTestVocabulary >> test: code [
	^ OpalCompiler new
		receiver:  self;
		evaluate: code
]

{ #category : #tests }
PetTestVocabulary >> test: name code: code [
	<keywordCommand: 'test'>
	| error res |
	color := Color blue.
	[ OpalCompiler new
		receiver: self;
		evaluate: code ]
		on: Exception
		do: [ :ex | 
			error := ex description.
			color := Color red ].
	res := name asText addAttribute: (TextColor color: color).
	color = Color red
		ifFalse: [ ^ res ].
	^ res , '\' withCRs , error asText , '\' withCRs , (code asText addAttribute: (TextColor color: Color red))
]
