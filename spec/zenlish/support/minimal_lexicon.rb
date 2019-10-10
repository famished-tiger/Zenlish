require_relative '../../../lib/zenlish/lex/empty_lexicon'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexicon'


common_noun = $ZenlishLexicon.name2terminal['CommonNoun']
adjective = $ZenlishLexicon.name2terminal['Adjective']
proper_noun = $ZenlishLexicon.name2terminal['ProperNoun']
irregular_verb = $ZenlishLexicon.name2terminal['IrregularVerb']
indefinite_pronoun = $ZenlishLexicon.name2terminal['IndefinitePronoun']
demonstrative_determiner = $ZenlishLexicon.name2terminal['DemonstrativeDeterminer']
definite_article = $ZenlishLexicon.name2terminal['DefiniteArticle']
cardinal = $ZenlishLexicon.name2terminal['Cardinal']
comparative_particle = $ZenlishLexicon.name2terminal['ComparativeParticle']
dot = $ZenlishLexicon.name2terminal['Period']

def add_entry(aLemma, aWordClass)
  entry = Zenlish::Lex::LexicalEntry.new(aLemma)
  raise StandardError, 'Unregistered word class' unless aWordClass
  lexeme = Zenlish::Lex::Lexeme.new(aWordClass, entry).freeze
  $ZenlishLexicon.add_entry(entry.freeze)
end

# Our minimalistic lexicon
add_entry('as', comparative_particle)
add_entry('Lisa', proper_noun)
add_entry('one', cardinal)
add_entry('other', adjective)
add_entry('people', common_noun)
add_entry('person', common_noun)
add_entry('same', adjective)
add_entry('see', irregular_verb)
add_entry('something', indefinite_pronoun)
add_entry('the', definite_article)
add_entry('thing', common_noun)
add_entry('this', demonstrative_determiner)
add_entry('Tony', proper_noun)
add_entry('two', cardinal)

add_entry('.', dot)
