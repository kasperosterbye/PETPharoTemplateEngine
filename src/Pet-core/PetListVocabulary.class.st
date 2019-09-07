Class {
	#name : #PetListVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'indentLevel'
	],
	#category : #'Pet-core'
}

{ #category : #examples }
PetListVocabulary class >> example [
	<example>
	| text |
	text := '
You can use the list command from the PetStandardVocabulary to initiate an list:
!list
!item {This is !b{element} 1}
!list
!item {This is !it{element} A}
!item {This is element B}
!end
!item {This is element 2}
!end
And then, this text comes after the list  	
	'.
	(PetEngine new
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetStandardVocabulary new;
		expand: text) inspect
]

{ #category : #accessing }
PetListVocabulary >> indentLevel [
	^ indentLevel
]

{ #category : #accessing }
PetListVocabulary >> indentLevel: anObject [
	indentLevel := anObject
]

{ #category : #accessing }
PetListVocabulary >> item: arg [
	<keywordCommand: 'item'>
	| expanded bullet |
	expanded := (engine expand: arg) addAttribute: (TextIndent tabs: indentLevel).
	bullet := (Text with: $• with: Character tab)
		addAttribute: (TextIndent tabs: indentLevel - 1).
	^ bullet, expanded
]
