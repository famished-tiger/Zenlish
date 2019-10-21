require_relative '../../../lib/zenlish/lex/empty_lexicon'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexicon'



adjective = $ZenlishLexicon.name2terminal['Adjective']
adverb = $ZenlishLexicon.name2terminal['Adverb']
adverb_not = $ZenlishLexicon.name2terminal['AdverbNot']
adverb_there = $ZenlishLexicon.name2terminal['AdverbThere']
degree_adverb = $ZenlishLexicon.name2terminal['DegreeAdverb']
auxiliary_be = $ZenlishLexicon.name2terminal['AuxiliaryBe']
auxiliary_do = $ZenlishLexicon.name2terminal['AuxiliaryDo']
common_noun = $ZenlishLexicon.name2terminal['CommonNoun']
linking_adverb = $ZenlishLexicon.name2terminal['LinkingAdverb']
proper_noun = $ZenlishLexicon.name2terminal['ProperNoun']
preposition = $ZenlishLexicon.name2terminal['Preposition']
preposition_of = $ZenlishLexicon.name2terminal['PrepositionOf']
preposition_than = $ZenlishLexicon.name2terminal['PrepositionThan']
regular_verb = $ZenlishLexicon.name2terminal['RegularVerb']
irregular_verb = $ZenlishLexicon.name2terminal['IrregularVerb']
irregular_verb_be = $ZenlishLexicon.name2terminal['IrregularVerbBe']
irregular_verb_say = $ZenlishLexicon.name2terminal['IrregularVerbSay']
indefinite_pronoun = $ZenlishLexicon.name2terminal['IndefinitePronoun']
conjunctive_pronoun = $ZenlishLexicon.name2terminal['ConjunctivePronoun']
demonstrative_pronoun = $ZenlishLexicon.name2terminal['DemonstrativePronoun']
demonstrative_determiner = $ZenlishLexicon.name2terminal['DemonstrativeDeterminer']
definite_article = $ZenlishLexicon.name2terminal['DefiniteArticle']
cardinal = $ZenlishLexicon.name2terminal['Cardinal']
comparative_particle = $ZenlishLexicon.name2terminal['ComparativeParticle']
indefinite_quantifier = $ZenlishLexicon.name2terminal['IndefiniteQuantifier']
subordinating_conjunction = $ZenlishLexicon.name2terminal['SubordinatingConjunction']

colon = $ZenlishLexicon.name2terminal['Colon']
comma = $ZenlishLexicon.name2terminal['Comma']
dot = $ZenlishLexicon.name2terminal['Period']
quote = $ZenlishLexicon.name2terminal['Quote']

def add_entry(aLemma, aWordClass)
  entry = Zenlish::Lex::LexicalEntry.new(aLemma)
  raise StandardError, "Undefined word class for '#{aLemma}'" unless aWordClass
  lexeme = Zenlish::Lex::Lexeme.new(aWordClass, entry).freeze
  $ZenlishLexicon.add_entry(entry.freeze)
end

# Our minimalistic lexicon
add_entry('about', preposition)
add_entry('above', preposition)
add_entry('alive', adjective)
add_entry('all', indefinite_quantifier)
add_entry('another', adjective)
add_entry('as', comparative_particle)
add_entry('be', auxiliary_be)
add_entry('be', irregular_verb_be)
add_entry('big', adjective)
add_entry('do', auxiliary_do)
add_entry('false', adjective)
add_entry('far', adverb)
add_entry('from', preposition)
add_entry('hear', irregular_verb)
add_entry('if', subordinating_conjunction)
add_entry('in', preposition)
add_entry('inside', preposition)
add_entry('kind', common_noun)
add_entry('Lisa', proper_noun)
add_entry('living', adjective)
add_entry('many', indefinite_quantifier)
add_entry('more', adjective)
add_entry('near to', preposition)
add_entry('not', adverb_not)
add_entry('of', preposition_of)
add_entry('on', preposition)
add_entry('one', cardinal)
add_entry('other', adjective)
add_entry('people', common_noun)
add_entry('person', common_noun)
add_entry('place', common_noun)
add_entry('same', adjective)
add_entry('say', irregular_verb_say)
add_entry('see', irregular_verb)
add_entry('side', common_noun)
add_entry('small', adjective)
add_entry('some', indefinite_quantifier)
add_entry('something', indefinite_pronoun)
add_entry('than', preposition_than)
add_entry('the', definite_article)
add_entry('then', linking_adverb)
add_entry('there', adverb_there)
add_entry('thing', common_noun)
add_entry('this', demonstrative_determiner)
add_entry('this', demonstrative_pronoun)
add_entry('this one', demonstrative_pronoun)
add_entry('to', preposition)
add_entry('Tony', proper_noun)
add_entry('touch', regular_verb)
add_entry('true', adjective)
add_entry('two', cardinal)
add_entry('very', degree_adverb)
add_entry('what',conjunctive_pronoun)
add_entry('word', common_noun)

add_entry(':', colon)
add_entry(',', comma)
add_entry('.', dot)
add_entry('"', quote)
