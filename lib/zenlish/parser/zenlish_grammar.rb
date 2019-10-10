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
  rule 'declarative_simple_sentence' => 'noun_phrase verb_phrase'
  rule 'noun_phrase' => 'noun_bar'
  rule 'noun_phrase' => 'determiner noun_bar'
  rule 'noun_phrase' => 'numeral noun_bar'  
  rule 'noun_phrase' => 'determiner numeral noun_bar'
  rule 'noun_phrase' => 'ProperNoun' 
  rule 'noun_phrase' => 'IndefinitePronoun'  
  rule 'noun_bar' => 'CommonNoun'
  rule 'noun_bar' => 'Adjective CommonNoun'
  rule 'noun_bar' => 'Adjective CommonNoun comparative_clause'  
  rule 'determiner' => 'DemonstrativeDeterminer'
  rule 'determiner' => 'DefiniteArticle'
  rule 'verb_phrase' => 'lexical_verb'
  rule 'verb_phrase' => 'lexical_verb noun_phrase'
  rule 'lexical_verb' => 'IrregularVerb'
  rule 'numeral' => 'Cardinal'
  rule 'comparative_clause' => 'comparative_start noun_phrase verb_phrase'
  rule 'comparative_start' => 'ComparativeParticle'
end

# CGE p. 354 The order of determiners: quantifier > article or demonstrative 
# or possessive > numeral > head

# And now build the grammar...
ZenlishGrammar = builder.grammar
