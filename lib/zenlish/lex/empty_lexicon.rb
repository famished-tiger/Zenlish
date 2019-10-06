unless defined?($ZenlishLexicon)
  require_relative 'empty_lexicon_factory'

  sandbox = Object.new
  sandbox.extend(Zenlish::Lex::EmptyLexiconFactory)
  $ZenlishLexicon = sandbox.create_empty_lexicon
end
