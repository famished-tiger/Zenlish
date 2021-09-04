# frozen_string_literal: true

require 'rley'

module Zenlish
  module Lex
    # An occurrence of a grammar terminal symbol that occurs in the input text.
    class Literal < Rley::Lexical::Token
      attr_reader :zlexeme

      # initialize(theLexeme, aTerminal, aPosition) ⇒ Token
      # @param literalText [String] the portion of input text that represents
      #   an occurence of the lexeme.
      # @param aLexeme [Lex::Lexeme] the lexeme matched by the literal text.
      # @param aPosition [Integer] the position of the literal in the input.
      def initialize(literalText, aLexeme, aPosition)
        super(literalText, aLexeme.wclass.name, aPosition)
        @zlexeme = aLexeme
      end
    end # class
  end # module
end # module
