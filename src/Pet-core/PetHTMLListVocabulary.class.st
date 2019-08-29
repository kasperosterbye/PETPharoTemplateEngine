Class {
	#name : #PetHTMLListVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'firstElement'
	],
	#category : #'Pet-core'
}

{ #category : #accessing }
PetHTMLListVocabulary >> endList [
	<keywordCommand: 'end'>
	engine popVocabulary.
	firstElement
		ifFalse: [ ^ '</li>\</ul>\' withCRs ].
	^ '</ul>'
]

{ #category : #'as yet unclassified' }
PetHTMLListVocabulary >> initalize [
	Transcript << 'HTML List init';cr;endEntry.
	firstElement := true
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
