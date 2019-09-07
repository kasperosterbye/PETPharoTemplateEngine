"
I am a list vocabulary. I need to be pushed by a '!list' command in some other vocabulary. I have just two commands.

!item which produce a new item, and !end which ends the list and pops me.
"
Class {
	#name : #PetHTMLListVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'firstElement'
	],
	#category : #'Pet-core'
}

{ #category : #examples }
PetHTMLListVocabulary class >> example [
	<example>
	| text |
	text := '
You can use the list command from the PetHTMLVocabulary to initiate an html list:
!list
!item This is element 1
!item This is element 2
!end
And then, this text comes after the list  	
	'.
	(PetEngine new
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetHTMLVocabulary new;
		expand: text) inspect
]

{ #category : #accessing }
PetHTMLListVocabulary >> endList [
	<keywordCommand: 'end'>
	engine popVocabulary.
	firstElement
		ifFalse: [ ^ '</li>\</ul>\' withCRs ].
	^ '</ul>'
]

{ #category : #'as yet unclassified' }
PetHTMLListVocabulary >> initialize [
	firstElement := true
]

{ #category : #accessing }
PetHTMLListVocabulary >> item [
	<keywordCommand: 'item'>
	firstElement
		ifFalse: [ ^ '</li>\<li>' withCRs ].
	firstElement := false.
	^ '<li>'
]
