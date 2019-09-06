Class {
	#name : #PetCodeVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'color'
	],
	#category : #'Pet-core'
}

{ #category : #examples }
PetCodeVocabulary class >> example [
	<example>
	| text |
	text := '
It is possible to refer to a method, and have its definition inlined:
!method{String}{asString}
Not the most interesting method, but a method nevertheless.	
	'.
	^PetTemplateEngine new 
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetCodeVocabulary new;
		expand: text
	
]

{ #category : #asserting }
PetCodeVocabulary >> assert: res equals: expected [
	color := res = expected
		ifTrue: [ Color r: 0 g: 0.5 b: 0.1 ]
		ifFalse: [ Color r: 0.7 g: 0.7 b: 0 ]
]

{ #category : #private }
PetCodeVocabulary >> class: className method: methodName [
	<keywordCommand: 'method'>
	| class compiledMethod sourceCode |
	class := SystemDictionary bindingOf: className asSymbol.
	class
		ifNil: [ ^ 'Could not find class: ' asText , className asText allBold , '!' ].
	class := class value.
	compiledMethod := class lookupSelector: methodName asSymbol.
	compiledMethod
		ifNil: [ ^ 'Could not find method ' asText , methodName asText allBold
				, ' in ' , className ].
	sourceCode := SHRBTextStyler new
		classOrMetaClass: class;
		styledTextFor: compiledMethod sourceCode asText.
	sourceCode addAttribute: (TextIndent tabs: 1).
	^ (className , ' >> ') asText , sourceCode
]

{ #category : #tests }
PetCodeVocabulary >> test: testName code: code [
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
	res := testName asText addAttribute: (TextColor color: color).
	color = Color red
		ifFalse: [ ^ res ].
	^ res , '\' withCRs , error asText , '\' withCRs , (code asText addAttribute: (TextColor color: Color red))
]
