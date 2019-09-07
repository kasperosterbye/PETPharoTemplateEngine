"
I am a parser which is able to sift out commands from the source stream.


"
Class {
	#name : #PetParser,
	#superclass : #Object,
	#instVars : [
		'in',
		'outStream',
		'state',
		'next',
		'ch',
		'cnt',
		'commandBuf',
		'argBuf',
		'argsBuf',
		'whiteSpace',
		'engine'
	],
	#category : #'Pet-core'
}

{ #category : #states }
PetParser >> argumentCollect [
	ch = self commandArgBeginChar 
		ifTrue: [ cnt := cnt + 1.
			argBuf nextPut: ch ].
	ch = self commandArgEndChar 
		ifTrue: [ cnt = 0
				ifTrue: [ argsBuf add: argBuf contents.
					self ignoreSpaceInit.
					next := $i ]
				ifFalse: [ cnt := cnt - 1.
					argBuf nextPut: ch ] ].
	({self commandArgBeginChar. self commandArgEndChar .} includes: ch)
		ifFalse: [ argBuf nextPut: ch ]
]

{ #category : #private }
PetParser >> argumentCollectInit [
	cnt := 0.
	argBuf := WriteStream on: String new.
]

{ #category : #public }
PetParser >> commandArgBeginChar [
	^ ${
]

{ #category : #public }
PetParser >> commandArgEndChar [
	^ $}
]

{ #category : #public }
PetParser >> commandBeginChar [
	^ $!
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
	ch = self commandArgBeginChar
		ifTrue: [ self argumentCollectInit.
			next := $a.
			^ self ].
	ch = self commandBeginChar & commandBuf isEmpty
		ifTrue: [ outStream nextPut: ch.
			next = $s.
			^ self ].
	ch = self commandBeginChar
		ifTrue: [ self emitCommand.
			self commandCollectInit.
			^ self ].
	self emitCommand.
	outStream nextPut: ch.
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

	outStream := (String new: 40) asText writeStream.
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
	^outStream contents.
]

{ #category : #private }
PetParser >> emitCommand [
	outStream nextPutAll: (engine execute: commandBuf contents with: argsBuf)
]

{ #category : #private }
PetParser >> handleLastCommand [
	state = $s
		ifTrue: [ ^ self ].
	state = $a
		ifTrue: [ argsBuf add: argBuf contents ].
	self emitCommand.
	state = $i
		ifTrue: [ outStream nextPutAll: whiteSpace contents ]
]

{ #category : #states }
PetParser >> ignoreSpace [
	ch asInteger <= 32
		ifTrue: [ whiteSpace nextPut: ch.
			^ self ].
	ch = self commandArgBeginChar
		ifTrue: [ self argumentCollectInit.
			next := $a.
			^ self ].
	ch = self commandBeginChar
		ifTrue: [ self emitCommand.
			self whiteSpaceEmit.
			self commandCollectInit.
			next := $c.
			^ self ].
	"something not a arg"
	self emitCommand.
	self whiteSpaceEmit.
	outStream nextPut: ch.
	next := $s
]

{ #category : #private }
PetParser >> ignoreSpaceInit [
	whiteSpace := WriteStream on: String new.
]

{ #category : #public }
PetParser >> onEngine: anEngine in: aStreamOrString [
	engine := anEngine.
	in := aStreamOrString.
	(in isKindOf: Stream)
		ifFalse: [ in := ReadStream on: in ].
	^ self convert
]

{ #category : #states }
PetParser >> stringCopy [
	ch = self commandBeginChar
		ifTrue: [ next := $c.
			self commandCollectInit ]
		ifFalse: [ outStream nextPut: ch ]
]

{ #category : #private }
PetParser >> whiteSpaceEmit [
	outStream nextPutAll: whiteSpace contents
]
