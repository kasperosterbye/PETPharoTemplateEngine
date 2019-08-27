"
I represent a standard vocabulary, with basic commands for: 

it -> italics
b -> bold
sup -> superscript
sub -> subsript
link -> hyperlink {text}{url}
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
