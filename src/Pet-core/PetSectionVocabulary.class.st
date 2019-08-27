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
PetSectionVocabulary >> levelString: level [
	^(counters first: level) joinUsing: '.'
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section1heading: hdr [
	<keywordCommand: 's1'>
	^ self section: '1' heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section2heading: hdr [
	<keywordCommand: 's2'>
	^ self section: '2' heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section3heading: hdr [
	<keywordCommand: 's3'>
	^ self section: '3' heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section4heading: hdr [
	<keywordCommand: 's4'>
	^ self section: '4' heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section5heading: hdr [
	<keywordCommand: 's5'>
	^ self section: '5' heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section6heading: hdr [
	<keywordCommand: 's6'>
	^ self section: '6' heading: hdr
]

{ #category : #'as yet unclassified' }
PetSectionVocabulary >> section: level heading: hdr [
	<keywordCommand: 'sec'>
	| hlevel res |
	hlevel := 'h' , level.
	res := '<' , hlevel , '>' , (self levelString: level asInteger) , ' '
		, hdr , '</' , hlevel , '>\n' withCRs.
	self incr: level asInteger.
	^res
]
