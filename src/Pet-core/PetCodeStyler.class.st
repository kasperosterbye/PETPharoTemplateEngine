Class {
	#name : #PetCodeStyler,
	#superclass : #SHRBTextStyler,
	#category : #'Pet-core'
}

{ #category : #private }
PetCodeStyler >> styleCompiledMethod: compiledMethod [ 
    | ast aText |
    ast := compiledMethod parseTree .
    ast methodNode compilationContext: (Smalltalk compiler compilationContextClass new
            class: (compiledMethod methodClass ifNil: [UndefinedObject]);
				forSyntaxHighlighting: true).
    ast doSemanticAnalysis.
	aText := compiledMethod sourceCode asText.
    self style: aText ast: ast.
    ^ aText
]
