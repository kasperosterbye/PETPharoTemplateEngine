"
A PetTemplateTest is a test class for testing the behavior of PetTemplate
"
Class {
	#name : #PetTemplateTest,
	#superclass : #TestCase,
	#category : #'Pet-core-Tests'
}

{ #category : #tests }
PetTemplateTest >> testCommandArg [
	| in res |
	in := 'www!foo{www}'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[www]»'
]

{ #category : #tests }
PetTemplateTest >> testCommandArgSpaceAtEnd [
	| in res |
	in := 'www!foo{www}  '.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[www]»  '
]

{ #category : #tests }
PetTemplateTest >> testCommandArgWithBraceInside [
	| in res |
	in := 'www!foo{ww{xxx}w}'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[ww{xxx}w]»'
]

{ #category : #tests }
PetTemplateTest >> testCommandNoArgs [
	| in res |
	in := 'www!foo www'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[]» www'
]

{ #category : #tests }
PetTemplateTest >> testCommandNoArgsAtEnd [
	| in res |
	in := 'www!foo'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[]»'
]

{ #category : #tests }
PetTemplateTest >> testCommandNoArgsAtEndWithWhiteSpace [
	| in res |
	in := 'www!foo '.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[]» '
]

{ #category : #tests }
PetTemplateTest >> testCommandTwoArg [
	| in res |
	in := 'www!foo{www}{mmm}'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[www§mmm]»'
]

{ #category : #tests }
PetTemplateTest >> testEmpty [ 
	| in res |
	in := ''.
	res := PetTemplateMock new expand: in.
	self assert: res equals: ''
]

{ #category : #tests }
PetTemplateTest >> testEmptyCommand [
	| in res |
	in := 'aaa!.bbb'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'aaa*.bbb'
]

{ #category : #tests }
PetTemplateTest >> testNoCommands [
	| in res |
	in := 'joe'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'joe'
]

{ #category : #tests }
PetTemplateTest >> testNoCommandsTwoLines [
	| in res |
	in := 'joe
lars'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'joe
lars'
]

{ #category : #tests }
PetTemplateTest >> testTwoCommandNoArgs [
	| in res |
	in := 'www!foo !bar www'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[]» «bar[]» www'
]

{ #category : #tests }
PetTemplateTest >> testTwoCommands [
	| in res |
	in := 'www!foo{www}aaa!bar{mmm}'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www«foo[www]»aaa«bar[mmm]»'
]

{ #category : #tests }
PetTemplateTest >> testTwoExclamations [
	| in res |
	in := 'www!!mmm'.
	res := PetTemplateMock new expand: in.
	self assert: res equals: 'www!«mmm[]»'
]
