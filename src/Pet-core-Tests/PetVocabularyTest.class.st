Class {
	#name : #PetVocabularyTest,
	#superclass : #TestCase,
	#instVars : [
		'engine'
	],
	#category : #'Pet-core-Tests'
}

{ #category : #running }
PetVocabularyTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	engine := PetEngine new
		pushVocabulary:  PetVocabularyBase new;
		pushVocabulary: PetMockVocabulary new
]

{ #category : #tests }
PetVocabularyTest >> testNoArg [
	| expanded |
	expanded := engine expand: 'aaa!noarg bbb'.
	self assert: expanded equals: 'aaano arg bbb'
]

{ #category : #tests }
PetVocabularyTest >> testOneArg [
	| expanded |
	expanded := engine expand: 'aaa !onearg{xxx} bbb'.
	self assert: expanded equals: 'aaa one xxx bbb'
]

{ #category : #tests }
PetVocabularyTest >> testTwoArg [
	| expanded |
	expanded := engine expand: 'aaa !twoarg{xxx}{yyy} bbb'.
	self assert: expanded equals: 'aaa two: xxx&yyy bbb'
]

{ #category : #tests }
PetVocabularyTest >> testTwoArgError [
	| expanded |
	expanded := engine expand: 'aaa !twoarg{xxx} bbb'.
	self assert: expanded equals: 'aaa  [ Argument number mismatch in "twoarg" expected: 2 but got: 1 ]  bbb'
]

{ #category : #tests }
PetVocabularyTest >> testVarArgs0 [
	| expanded |
	expanded := engine expand: 'aaa !var bbb'.
	self assert: expanded equals: 'aaa var:  bbb'
]

{ #category : #tests }
PetVocabularyTest >> testVarArgs1 [
	| expanded |
	expanded := engine expand: 'aaa !var{xxx} bbb'.
	self assert: expanded equals: 'aaa var: xxx bbb'
]

{ #category : #tests }
PetVocabularyTest >> testVarArgs3 [
	| expanded |
	expanded := engine expand: 'aaa !var{xxx}{yyy}{zzz} bbb'.
	self assert: expanded equals: 'aaa var: xxx-yyy-zzz bbb'
]
