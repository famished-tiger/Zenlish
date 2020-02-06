module Zenlish
  module Lex
    # TODO: document
    class LexicalEntry
      #@return [String] the lemma (dictionary) form of a word.
      attr_reader :lemma

      # @return [Array<Lexeme, Rley::Syntax::Terminal>]
      attr_reader :lexemes

      # @param theLemma [String] lemma (= citation form), a word form used 
      #   conventionnaly to represent a lexeme.
      # @param aLexeme [Lexeme, NilClass] the lexeme to link with lexical entry.
      def initialize(theLemma, aLexeme = nil)
        @lemma = theLemma.dup
        @lexemes = []
        add_lexeme(aLexeme)
      end

      # @param aLexeme [Lexeme, NilClass] the lexeme to link with lexical entry.      
      def add_lexeme(aLexeme)
        lexemes << aLexeme if aLexeme
      end
    end # class
  end # module
end # module