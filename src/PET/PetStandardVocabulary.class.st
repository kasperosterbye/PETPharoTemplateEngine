"
I represent a standard vocabulary, with basic commands for: 

it -> italics
b -> bold
sup -> superscript
sub -> subsript

Note to Kasper:
You set the font of a text using: 
'myText' asText  addAttribute: (TextFontReference toFont: font).

You can get a list of font families using: 
StrikeFont  actualFamilyNames


You get an actual font from a family using: 
StrikeFont familyName: 'Bitmap Source Sans Pro' pointSize: 18.
"
Class {
	#name : #PetStandardVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'indentLevel'
	],
	#category : #'PET-Text'
}

{ #category : #examples }
PetStandardVocabulary class >> example [
	<example>
	| text |
	text := '
We support !b{bold}, !it{italics}, both !b{bold with !it{italics} embedded}.
We can also do verbatim
!verbatim 
Here we have !b{should not bold}.
!list do not list
!error{} is not an error
!endVerbatim
And now we are back in doing !b{bold}.
'.
	(PetEngine new
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetStandardVocabulary new;
		expand: text) inspect
]

{ #category : #'as yet unclassified' }
PetStandardVocabulary >> bold: txt [
	<keywordCommand: 'b'>
	| expanded |
	expanded := engine expand: txt.
	^ expanded allBold
]

{ #category : #accessing }
PetStandardVocabulary >> endlist [
	<keywordCommand: 'end'>
	engine popVocabulary.
	indentLevel := indentLevel - 1.
	^ Text new
]

{ #category : #initialization }
PetStandardVocabulary >> initialize [
	indentLevel := 0.
	
]

{ #category : #'as yet unclassified' }
PetStandardVocabulary >> italics: txt [
	<keywordCommand: 'it'>
	| expanded |
	expanded := engine expand: txt.
	^ expanded addAttribute: TextEmphasis italic
]

{ #category : #accessing }
PetStandardVocabulary >> list [
	<keywordCommand: 'list'>
	indentLevel := indentLevel + 1.
	engine
		pushVocabulary: (PetListVocabulary new
		indentLevel: indentLevel).
	^ Text new
]

{ #category : #'as yet unclassified' }
PetStandardVocabulary >> subscript: txt [
	<keywordCommand: 'sub'>
	| expanded |
	expanded := engine expand: txt.
	^ '<sub>' , expanded , '</sub>'
]

{ #category : #'as yet unclassified' }
PetStandardVocabulary >> superscript: txt [
	<keywordCommand: 'sup'>
	| expanded |
	expanded := engine expand: txt.
	^ '<sup>' , expanded , '</sup>' 
]

{ #category : #'as yet unclassified' }
PetStandardVocabulary >> verbatim [
	<keywordCommand: 'verbatim'>
	engine pushVocabulary: PetVerbatimVocabulary new.
	^ ''asText
]
