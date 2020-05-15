"
I am a vocabulary for inlining code.

See the individual commands for help.
"
Class {
	#name : #PetCodeVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'color'
	],
	#category : #'PET-Text'
}

{ #category : #examples }
PetCodeVocabulary class >> exampleMethodInclude [
	<example>
	| text |
	text := 'It is possible to refer to a method, and have its definition inlined:
!method{String}{asString}
Not the most interesting method, but a method nevertheless.	
'.
	(PetEngine new
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetCodeVocabulary new;
		expand: text) inspect
]

{ #category : #examples }
PetCodeVocabulary class >> exampleTests [
	<example>
	| text |
	text := 'You can write a test inline:
!test{2+2 is 4}{self assert: 2 + 2 equals: 4}
!test{2+2 is 5}{self assert: 2 + 2 equals: 5}
!test{Did no assert}{2+2=4}
!test{2/0 is bad}{self assert: 2/0 equals: 7}
'.
	(PetEngine new
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetCodeVocabulary new;
		expand: text) inspect
]

{ #category : #examples }
PetCodeVocabulary class >> exampleUML [
	<example>
	| text |
	text := 'You can write plant uml inline:
!uml{
@startmindmap
* Debian
** Ubuntu
*** Linux Mint
*** Kubuntu
*** Lubuntu
*** KDE Neon
** LMDE
** SolydXK
** SteamOS
** Raspbian with a very long name
*** <s>Raspmbc</s> => OSMC
*** <s>Raspyfi</s> => Volumio
@endmindmap
}
Cool - eh?
'.
	(PetEngine new
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetCodeVocabulary new;
		expand: text) inspect
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

{ #category : #tests }
PetCodeVocabulary >> uml: uml [
	<keywordCommand: 'uml'>
	| encoded serverUrl anchoredImage |
	encoded := "uml plantDeflateAndEncode" nil.
	serverUrl := 'https://www.plantuml.com/plantuml/img/' , encoded.
	anchoredImage := (String value: 1) asText
		addAttribute: (TextAnchor new anchoredMorph: (ZnEasy getPng: serverUrl)).
	^ anchoredImage
]
