Class {
	#name : #PetMockVocabulary,
	#superclass : #PetVocabulary,
	#category : #'Pet-core-Tests'
}

{ #category : #'as yet unclassified' }
PetMockVocabulary >> noArg [
	<keywordCommand: 'noarg'>
	^'no arg'
]

{ #category : #'as yet unclassified' }
PetMockVocabulary >> oneArg: arg [
	<keywordCommand: 'onearg'>
	^'one ', arg
]

{ #category : #'as yet unclassified' }
PetMockVocabulary >> twoArg: arg1 arg: arg2 [
	<keywordCommand: 'twoarg'>
	^'two: ', arg1, '&', arg2
]

{ #category : #'as yet unclassified' }
PetMockVocabulary >> varArgs: args [
	<keywordCommand: 'var' vararg: true>
	^ 'var: ' , (args joinUsing: '-')
]
