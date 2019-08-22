Class {
	#name : #PetParser,
	#superclass : #Object,
	#instVars : [
		'template',
		'in',
		'out',
		'state',
		'next',
		'ch',
		'cnt',
		'commandBuf',
		'argBuf',
		'argsBuf',
		'whiteSpace'
	],
	#category : #'Pet-core'
}

{ #category : #states }
PetParser >> argumentCollect [
	ch = ${
		ifTrue: [ cnt := cnt + 1.
			argBuf nextPut: ch ].
	ch = $}
		ifTrue: [ cnt = 0
				ifTrue: [ argsBuf add: argBuf contents.
					self ignoreSpaceInit .
					next := $i ]
				ifFalse: [ cnt := cnt - 1.
					argBuf nextPut: ch ] ].
	('{}' includes: ch)
		ifFalse: [ argBuf nextPut: ch ]
]

{ #category : #private }
PetParser >> argumentCollectInit [
	cnt := 0.
	argBuf := WriteStream on: String new.
]

{ #category : #states }
PetParser >> commandCollect [
	ch isAlphaNumeric
		ifTrue: [ commandBuf nextPut: ch.
			^ self ].
	ch asInteger <= 32
		ifTrue: [ self ignoreSpaceInit.
			whiteSpace nextPut: ch.
			next := $i.
			^ self ].
	ch = ${
		ifTrue: [ self argumentCollectInit.
			next := $a.
			^ self ].
	ch = $!
		ifTrue: [ self emitCommand.
			self commandCollectInit.
			^ self ].
	"command ended with some special character - eg. .,; or the like"
	self emitCommand.
	out nextPut: ch.
	next := $s
]

{ #category : #private }
PetParser >> commandCollectInit [
	commandBuf := WriteStream on: String new.
	argsBuf :=  OrderedCollection new
]

{ #category : #private }
PetParser >> convert [
	"return the converted in"

	out := WriteStream on: Text new.
	state := $s.
	[ in atEnd ]
		whileFalse: [ ch := in next.
			next := state.
			state = $s
				ifTrue: [ self stringCopy ].
			state = $c
				ifTrue: [ self commandCollect ].
			state = $i
				ifTrue: [ self ignoreSpace ].
			state = $a
				ifTrue: [ self argumentCollect ].
			state := next ].
	self handleLastCommand.
	^ out contents
]

{ #category : #private }
PetParser >> emitCommand [
	out nextPutAll: (template execute: commandBuf contents with: argsBuf)
]

{ #category : #private }
PetParser >> handleLastCommand [
	state = $s
		ifTrue: [ ^ self ].
	state = $a
		ifTrue: [ argsBuf add: argBuf contents ].
	self emitCommand.
	state = $i
		ifTrue: [ out nextPutAll: whiteSpace contents ]
]

{ #category : #states }
PetParser >> ignoreSpace [
	ch asInteger <= 32
		ifTrue: [ whiteSpace nextPut: ch.
			^ self ].
	ch = ${
		ifTrue: [ self argumentCollectInit.
			next := $a.
			^ self ].
	ch = $!
		ifTrue: [ self emitCommand.
			self commandCollectInit.
			next := $c ].
	"something not a arg"
	self emitCommand.
	self whiteSpaceEmit.
	out nextPut: ch.
	next := $s
]

{ #category : #private }
PetParser >> ignoreSpaceInit [
	whiteSpace := WriteStream on: String new.
]

{ #category : #public }
PetParser >> onTemplate: templ in: aStreamOrString [
	template := templ.
	in := aStreamOrString.
	(in isKindOf: Stream)
		ifFalse: [ in := ReadStream on: in ].
	^ self convert
]

{ #category : #states }
PetParser >> stringCopy [
	ch = $!
		ifTrue: [ next := $c.
			self commandCollectInit ]
		ifFalse: [ out nextPut: ch ]
]

{ #category : #private }
PetParser >> whiteSpaceEmit [
	out nextPutAll: whiteSpace contents.
]
