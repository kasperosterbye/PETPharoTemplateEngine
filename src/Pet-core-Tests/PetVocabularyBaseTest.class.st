"
A PetVocabularyBaseTest is a test class for testing the behavior of PetVocabularyBase
"
Class {
	#name : #PetVocabularyBaseTest,
	#superclass : #TestCase,
	#category : #'Pet-core-Tests'
}

{ #category : #tests }
PetVocabularyBaseTest >> testNoCommands [
	| input output |
	input := 'there are no commands, but a line break
		and two tabs'.
	output := PetTemplateEngine new
		pushVocabulary:  PetVocabularyBase new;
		expand: input.
	self assert: output equals: input
]
