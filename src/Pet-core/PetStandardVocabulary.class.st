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
	#category : #'Pet-core'
}

{ #category : #'as yet unclassified' }
PetStandardVocabulary >> bold: txt [
	<keywordCommand: 'b'>
	| expanded |
	expanded := engine expand: txt.
	^ expanded allBold
]

{ #category : #'as yet unclassified' }
PetStandardVocabulary >> italics: txt [
	<keywordCommand: 'it'>
	| expanded |
	expanded := engine expand: txt.
	^ expanded addAttribute: TextEmphasis italic
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
