require_relative '../../../lib/zenlish/lex/empty_lexicon'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexicon'

def add_entry(aLemma, aWordClass)
  entry = Zenlish::Lex::LexicalEntry.new(aLemma)
  lexeme = Zenlish::Lex::Lexeme.new(aWordClass, entry)
  $ZenlishLexicon.add_entry(entry)
end

common_noun = $ZenlishLexicon.name2terminal['CommonNoun']
adjective = $ZenlishLexicon.name2terminal['Adjective']
proper_noun = $ZenlishLexicon.name2terminal['ProperNoun']
irregular_verb = $ZenlishLexicon.name2terminal['IrregularVerb']
indefinite_pronoun = $ZenlishLexicon.name2terminal['IndefinitePronoun']
demonstrative_determiner = $ZenlishLexicon.name2terminal['DemonstrativeDeterminer']
definite_article =  $ZenlishLexicon.name2terminal['DefiniteArticle']
dot = $ZenlishLexicon.name2terminal['Period']

add_entry('Lisa', proper_noun)
add_entry('other', adjective)
add_entry('see', irregular_verb)
add_entry('something', indefinite_pronoun)
add_entry('the', definite_article)
add_entry('thing', common_noun)
add_entry('this', demonstrative_determiner)
add_entry('Tony', proper_noun)

add_entry('.', dot)
