"
I implement section commands. 
s1, s2, ... s6
"
Class {
	#name : #PetSectionVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'counters'
	],
	#category : #'Pet-core'
}

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> incr: index [
	counters at: index put: (counters at: index) + 1.
	index + 1 to: counters size do: [ :i | counters at: i put: 1 ]
]

{ #category : #initialization }
PetSectionVocabulary >> initialize [
	counters := #(1 1 1 1 1 1) copy 
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> levelFont: level [
	"I return a font annotation to be used with Attributes"

	"StrikeFont actualFamilyNames an OrderedCollection(#'Bitmap DejaVu Sans' #'Bitmap Source Code Pro' #'Bitmap Source Sans Pro')"

	| fontSizes |
	fontSizes := #(24 20 18 16 14 14).
	^ TextFontReference
		toFont:
			(StrikeFont
				familyName: 'Bitmap Source Sans Pro'
				pointSize: (fontSizes at: level))
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> levelString: level [
	^(counters first: level) joinUsing: '.'
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section1heading: hdr [
	<keywordCommand: 's1'>
	^ self section: 1 heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section2heading: hdr [
	<keywordCommand: 's2'>
	^ self section: 2 heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section3heading: hdr [
	<keywordCommand: 's3'>
	^ self section: 3 heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section4heading: hdr [
	<keywordCommand: 's4'>
	^ self section: 4 heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section5heading: hdr [
	<keywordCommand: 's5'>
	^ self section: 5 heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section6heading: hdr [
	<keywordCommand: 's6'>
	^ self section: 6 heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section: level heading: hdr [
	| heading |
	heading := (self levelString: level) asText, ' ', (engine expand: hdr).
	self incr: level.
	^heading addAttribute: (self levelFont: level)
]
