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
  rule 'simple_sentence' => 'declarative_simple_sentence'
  rule 'declarative_simple_sentence' => 'noun_phrase verb_phrase Period'
  rule 'noun_phrase' => 'noun'
  rule 'noun' => 'ProperNoun'
  rule 'noun' => 'CommonNoun'
  rule 'verb_phrase' => 'lexical_verb complement'
  rule 'lexical_verb' => 'IrregularVerb'
  rule 'complement' => 'ProperNoun'
  rule 'complement' => 'IndefinitePronoun'
  rule 'complement' => 'DemonstrativeDeterminer noun'
  rule 'complement' => 'DefiniteArticle Adjective CommonNoun'
end

# And now build the grammar...
ZenlishGrammar = builder.grammar
