"
I implement section commands. 
s1, s2, ... s6
"
Class {
	#name : #PetHTMLSectionVocabulary,
	#superclass : #PetVocabulary,
	#instVars : [
		'counters'
	],
	#category : #'PET-HTML'
}

{ #category : #examples }
PetHTMLSectionVocabulary class >> example [
	<example>
	| text |
	text := '
Sections in HTML can be used in the following form.
!s1{Heading AAA}
!s2{Heading BBB}
!s2{Heading CCC}
!s1{Heading DDD}
!s2{Heading EEE}
!s3{Heading FFF}
'.
	(PetEngine new
		pushVocabulary: PetVocabularyBase new;
		pushVocabulary: PetHTMLSectionVocabulary new;
		expand: text) inspect
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> incr: index [
	counters at: index put: (counters at: index) + 1.
	index + 1 to: counters size do: [ :i | counters at: i put: 0 ]
]

{ #category : #initialization }
PetHTMLSectionVocabulary >> initialize [
	counters := #(0 0 0 0 0 0) copy
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> levelString: level [
	^(counters first: level) joinUsing: '.'
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> section1heading: hdr [
	<keywordCommand: 's1'>
	^ self section: '1' heading: hdr
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> section2heading: hdr [
	<keywordCommand: 's2'>
	^ self section: '2' heading: hdr
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> section3heading: hdr [
	<keywordCommand: 's3'>
	^ self section: '3' heading: hdr
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> section4heading: hdr [
	<keywordCommand: 's4'>
	^ self section: '4' heading: hdr
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> section5heading: hdr [
	<keywordCommand: 's5'>
	^ self section: '5' heading: hdr
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> section6heading: hdr [
	<keywordCommand: 's6'>
	^ self section: '6' heading: hdr
]

{ #category : #'as yet unclassified' }
PetHTMLSectionVocabulary >> section: level heading: hdr [
	<keywordCommand: 'sec'>
	| hlevel res |
	self incr: level asInteger.
	hlevel := 'h' , level.
	res := '<' , hlevel , '>' , (self levelString: level asInteger) , ' '
		, hdr , '</' , hlevel , '>\' withCRs.
	^ res
]
