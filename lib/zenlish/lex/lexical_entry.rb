module Zenlish
  module Lex
    # TODO: document
    class LexicalEntry
      attr_reader :lemma
      attr_reader :lexemes
      
      def initialize(theLemma, aLexeme = nil)
        @lemma = theLemma.dup
        @lexemes = []
        add_lexeme(aLexeme)
      end
      
      def add_lexeme(aLexeme)
        lexemes << aLexeme if aLexeme
      end
    end # class
  end # module    
end # module