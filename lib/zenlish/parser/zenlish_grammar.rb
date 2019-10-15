# Grammar for a simple subset of English language
# It is called Zenlish

require 'rley' # Load the Rley parsing library
require_relative '../lex/empty_lexicon'

########################################
# Define a grammar for a highly English-like language
builder = Rley::Syntax::GrammarBuilder.new do
  add_terminals(*$ZenlishLexicon.terminals)
  # add_terminals('Period')

  rule 'language' => 'sentence'
  rule 'sentence' => 'simple_sentence'
  rule 'simple_sentence' => 'declarative_simple_sentence Period'
  rule 'declarative_simple_sentence' => 'affirmative_sentence'  
  rule 'declarative_simple_sentence' => 'negative_sentence'
  rule 'affirmative_sentence' => 'noun_phrase verb_phrase'
  rule 'affirmative_sentence' => 'AdverbThere IrregularVerbBe verb_complement'  
  rule 'negative_sentence' => 'noun_phrase negative_verb_phrase'
  rule 'negative_sentence' => 'AdverbThere negative_verb_phrase'  
  rule 'noun_phrase' => 'nominal'
  rule 'noun_phrase' => 'determiner nominal'
  rule 'noun_phrase' => 'numeral nominal'
  
  # Case: ... one of these things.
  rule 'noun_phrase' => 'numeral Preposition DemonstrativeDeterminer noun_phrase'
  rule 'noun_phrase' => 'numeral Preposition DemonstrativeDeterminer'   
  rule 'noun_phrase' => 'determiner numeral nominal' 
  
  # CGE p.359, 360: of + definite noun phrase
  rule 'noun_phrase' => 'determiner Preposition DemonstrativeDeterminer noun_phrase' 
  rule 'noun_phrase' => 'ProperNoun'
  rule 'noun_phrase' => 'DemonstrativePronoun'  
  rule 'noun_phrase' => 'IndefinitePronoun'  
  rule 'nominal' => 'CommonNoun'
  rule 'nominal' => 'Adjective CommonNoun'
  rule 'nominal' => 'Adjective CommonNoun comparative_clause'
  rule 'determiner' => 'determiner single_determiner'
  rule 'determiner' => 'single_determiner'  
  rule 'single_determiner' => 'DemonstrativeDeterminer'
  rule 'single_determiner' => 'DefiniteArticle'
  rule 'single_determiner' => 'IndefiniteQuantifier'
  rule 'verb_phrase' => 'lexical_verb'
  rule 'verb_phrase' => 'lexical_verb verb_complement'
  rule 'verb_phrase' => 'IrregularVerbBe verb_be_complement'
  rule 'verb_complement' => 'noun_phrase'
  rule 'verb_complement' => 'adverb_phrase'   
  rule 'verb_complement' => 'propositional_phrase'
  rule 'verb_complement' => 'noun_phrase adverb_phrase'
  rule 'verb_complement' => 'noun_phrase propositional_phrase'
  rule 'verb_be_complement' => 'adjective_as_complement'  # Specific to be as lexical verb
  rule 'adjective_as_complement' => 'DegreeAdverb Adjective'
  rule 'adjective_as_complement' => 'Adjective'
  rule 'negative_verb_phrase' => 'IrregularVerbBe AdverbNot verb_complement'
  rule 'negative_verb_phrase' => 'IrregularVerbBe AdverbNot Adjective'  
  rule 'negative_verb_phrase' => 'AuxiliaryDo AdverbNot verb_phrase'
  rule 'lexical_verb' => 'IrregularVerb'
  rule 'lexical_verb' => 'IrregularVerbBe'
  rule 'numeral' => 'Cardinal'
  rule 'comparative_clause' => 'comparative_start noun_phrase'  
  rule 'comparative_clause' => 'comparative_start affirmative_sentence'
  rule 'comparative_start' => 'PrepositionThan'  
  rule 'comparative_start' => 'ComparativeParticle'
  rule 'adverb_phrase' => 'Adverb'
  rule 'adverb_phrase' => 'Adverb propositional_phrase'
  rule 'propositional_phrase' => 'Preposition propositional_complement'
  rule 'propositional_complement' => 'noun_phrase'
end


# CGE p. 354 The order of determiners: quantifier > article or demonstrative 
# or possessive > numeral > head

# And now build the grammar...
ZenlishGrammar = builder.grammar
