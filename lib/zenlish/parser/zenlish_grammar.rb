# Grammar for a simple subset of English language
# It is called Zenlish

require 'rley' # Load the Rley parsing library
require_relative '../lex/empty_lexicon'

########################################
# Define a grammar for a highly English-like language
builder = Rley::Syntax::GrammarBuilder.new do
  add_terminals(*$ZenlishLexicon.terminals)

  rule 'language' => 'sentence'
  rule 'sentence' => 'simple_sentence Period'
  rule 'sentence' => 'complex_sentence Period'
  rule 'simple_sentence' => 'declarative_simple_sentence'
  rule 'complex_sentence' => 'main_clause subordination_marker dependent_clause'
  rule 'complex_sentence' => 'main_clause Comma subordination_marker dependent_clause'
  rule 'complex_sentence' => 'subordination_marker dependent_clause Comma main_clause'
  rule 'complex_sentence' => 'subordination_marker dependent_clause Comma LinkingAdverb main_clause'
  rule 'subordination_marker' => 'SubordinatingConjunction'
  rule 'subordination_marker' => 'SubordinatingConjunction PrepositionOf'
  rule 'declarative_simple_sentence' => 'affirmative_sentence'
  rule 'declarative_simple_sentence' => 'negative_sentence'
  rule 'main_clause' => 'simple_sentence'
  rule 'dependent_clause' => 'simple_sentence'
  rule 'dependent_clause' => 'DemonstrativePronoun'
  rule 'affirmative_sentence' => 'noun_phrase verb_phrase'
  rule 'affirmative_sentence' => 'propositional_phrase Comma noun_phrase verb_phrase'
  rule 'affirmative_sentence' => 'AdverbThere IrregularVerbBe verb_be_complement'
  rule 'affirmative_sentence' => 'numeral_of IrregularVerbBe verb_be_complement'
  rule 'affirmative_sentence' => 'DemonstrativePronoun IrregularVerbBe verb_be_complement'
  rule 'affirmative_sentence' => 'DemonstrativePronoun IrregularVerb verb_complement'
  rule 'affirmative_sentence' => 'conjunctive_prefix IrregularVerbBe verb_be_complement'

  # Case of time adjunct adverbial put in fromt position
  rule 'affirmative_sentence' => 'simple_noun_phrase Adverb Comma noun_phrase verb_phrase'
  rule 'negative_sentence' => 'noun_phrase negative_verb_phrase'
  rule 'negative_sentence' => 'AdverbThere negative_verb_phrase'
  rule 'negative_sentence' => 'numeral_of negative_verb_phrase'
  rule 'negative_sentence' => 'DemonstrativePronoun negative_verb_phrase'
  rule 'negative_sentence' => 'conjunctive_prefix negative_verb_phrase'
  rule 'conjunctive_prefix' => 'ConjunctivePronoun noun_phrase verb_phrase'
  rule 'noun_phrase' => 'simple_noun_phrase'
  rule 'noun_phrase' => 'compound_noun_phrase'
  rule 'simple_noun_phrase' => 'nominal'
  rule 'simple_noun_phrase' => 'determiner nominal'
  rule 'simple_noun_phrase' => 'numeral nominal'
  rule 'simple_noun_phrase' => 'determiner numeral nominal'
  rule 'simple_noun_phrase' => 'simple_noun_phrase simple_noun_phrase verb_phrase'

  # Case: (all|many|some) one of (this|these)
  rule 'simple_noun_phrase' => 'subset_of noun_phrase'

  # CGE p.359, 360: <numeral> of + definite noun phrase
  rule 'simple_noun_phrase' => 'numeral_of noun_phrase'
  rule 'simple_noun_phrase' => 'ProperNoun'
  # rule 'simple_noun_phrase' => 'DemonstrativePronoun'
  rule 'simple_noun_phrase' => 'IndefinitePronoun'
  rule 'simple_noun_phrase' => 'IndefinitePronoun Adjective'


  rule 'compound_noun_phrase' => 'simple_noun_phrase propositional_phrase'
  rule 'compound_noun_phrase' => 'simple_noun_phrase comparative_clause'

  # <numeral> of this/these...
  rule 'numeral_of' => 'numeral PrepositionOf DemonstrativeDeterminer'
  rule 'numeral_of' => 'numeral PrepositionOf DefiniteArticle'
  rule 'subset_of' => 'IndefiniteQuantifier PrepositionOf DemonstrativeDeterminer'
  rule 'nominal' => 'CommonNoun'
  rule 'nominal' => 'Adjective CommonNoun'
  rule 'determiner' => 'determiner single_determiner'
  rule 'determiner' => 'single_determiner'
  rule 'single_determiner' => 'DemonstrativeDeterminer'
  rule 'single_determiner' => 'DefiniteArticle'
  rule 'single_determiner' => 'IndefiniteArticle'
  rule 'single_determiner' => 'IndefiniteQuantifier'
  rule 'verb_phrase' => 'verb_group'
  rule 'verb_phrase' => 'verb_group verb_complement'
  rule 'verb_phrase' => 'RegularVerb propositional_phrase'
  rule 'verb_phrase' => 'RegularVerbWant Preposition verb_group'
  rule 'verb_phrase' => 'RegularVerbWant Preposition verb_group noun_phrase'
  rule 'verb_phrase' => 'IrregularVerbDo DemonstrativePronoun'
  rule 'verb_phrase' => 'IrregularVerbDo DemonstrativePronoun propositional_phrase'
  rule 'verb_phrase' => 'ModalVerbCan verb_group DemonstrativePronoun'
  rule 'verb_phrase' => 'IrregularVerbBe verb_be_complement'
  rule 'verb_phrase' => 'IrregularVerbSay Colon Quote affirmative_sentence Period Quote'
  rule 'verb_complement' => 'noun_phrase'
  # perception verb (hear, see, watch, notice, ...): verb + object + infinitive
  rule 'verb_complement' => 'simple_noun_phrase lexical_verb'
  rule 'verb_complement' => 'Adjective propositional_phrase'
  rule 'verb_complement' => 'noun_phrase IrregularVerbBe verb_be_complement'
  rule 'verb_complement' => 'adverb_phrase'
  rule 'verb_complement' => 'noun_phrase adverb_phrase'
  rule 'verb_be_complement' => 'noun_phrase'
  rule 'verb_be_complement' => 'adjective_as_complement'  # Specific to be as lexical verb
  rule 'verb_be_complement' => 'propositional_phrase'
  rule 'adjective_as_complement' => 'DegreeAdverb Adjective'
  rule 'adjective_as_complement' => 'Adjective'
  rule 'adjective_as_complement' => 'Adjective comparative_clause'
  rule 'negative_verb_phrase' => 'IrregularVerbBe AdverbNot verb_be_complement'
  rule 'negative_verb_phrase' => 'AuxiliaryDo AdverbNot verb_phrase'
  # rule 'negative_verb_phrase' => 'ModalVerbCan AdverbNot verb_phrase'
  rule 'negative_verb_phrase' => 'ModalVerbCan AdverbNot verb_group DemonstrativePronoun'
  rule 'verb_group' => 'lexical_verb'
  rule 'verb_group' => 'AuxiliaryBe lexical_verb'
  rule 'verb_group' => 'ModalVerbCan lexical_verb'
  rule 'lexical_verb' => 'RegularVerb'
  rule 'lexical_verb' => 'RegularVerbWant'
  rule 'lexical_verb' => 'IrregularVerb'
  rule 'lexical_verb' => 'IrregularVerbBe'
  rule 'lexical_verb' => 'IrregularVerbDo'
  rule 'lexical_verb' => 'IrregularVerbHave'
  rule 'lexical_verb' => 'IrregularVerbSay'
  rule 'numeral' => 'Cardinal'
  rule 'comparative_clause' => 'comparative_start noun_phrase'
  rule 'comparative_clause' => 'comparative_start affirmative_sentence'
  rule 'comparative_clause' => 'comparative_start DefiniteArticle Adjective Cardinal'
  rule 'comparative_start' => 'PrepositionThan'
  rule 'comparative_start' => 'ComparativeParticle'
  rule 'adverb_phrase' => 'Adverb'
  rule 'adverb_phrase' => 'Adverb propositional_phrase'
  rule 'propositional_phrase' => 'preposition propositional_complement'
  rule 'propositional_phrase' => 'preposition'
  rule 'propositional_complement' => 'noun_phrase'
  rule 'preposition' => 'Preposition'
  rule 'preposition' => 'PrepositionOf'
end


# CGE p. 354 The order of determiners: quantifier > article or demonstrative
# or possessive > numeral > head

# And now build the grammar...
ZenlishGrammar = builder.grammar
