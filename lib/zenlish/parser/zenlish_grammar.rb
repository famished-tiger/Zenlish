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
  rule 'noun_phrase' => 'nominal'
  rule 'noun_phrase' => 'determiner nominal'
  rule 'noun_phrase' => 'numeral nominal'  
  rule 'noun_phrase' => 'determiner numeral nominal'
  rule 'noun_phrase' => 'ProperNoun' 
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
  rule 'verb_phrase' => 'lexical_verb noun_phrase'
  rule 'verb_phrase' => 'lexical_verb adverb_phrase'  
  rule 'verb_phrase' => 'lexical_verb propositional_phrase'
  rule 'verb_phrase' => 'lexical_verb noun_phrase adverb_phrase'
  rule 'verb_phrase' => 'lexical_verb noun_phrase propositional_phrase'  
  rule 'lexical_verb' => 'IrregularVerb'
  rule 'numeral' => 'Cardinal'
  rule 'comparative_clause' => 'comparative_start noun_phrase verb_phrase'
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
