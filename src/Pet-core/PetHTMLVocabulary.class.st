"
I represent a standard vocabulary, with basic commands for: 

it -> italics
b -> bold
sup -> superscript
sub -> subsript
link -> hyperlink {text}{url}
"
Class {
	#name : #PetHTMLVocabulary,
	#superclass : #PetVocabulary,
	#category : #'Pet-core'
}

{ #category : #'as yet unclassified' }
PetHTMLVocabulary >> anchor: txt url: url [
	<keywordCommand: 'link'>
	| expanded |
	expanded := engine expand: txt.
	^ '<a href="' , url , '">' , expanded , '</a>'
]

{ #category : #'as yet unclassified' }
PetHTMLVocabulary >> beginList [
	<keywordCommand: 'list'>
	self halt.
	engine pushVocabulary: PetHTMLListVocabulary new.
	^ '<ul>'
]

{ #category : #formatting }
PetHTMLVocabulary >> bold: txt [
	<keywordCommand: 'b'>
	| expanded |
	expanded := engine expand: txt.
	^ '<b>', expanded, '</b>'
]

{ #category : #'as yet unclassified' }
PetHTMLVocabulary >> italics: txt [
	<keywordCommand: 'it'>
	| expanded |
	expanded := engine expand: txt.
	^ '<em>' , expanded , '</em'
]
