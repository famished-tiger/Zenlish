require 'rley'

module Zenlish
  module Lex
    # TODO: document
    class Literal < Rley::Lexical::Token
      attr_reader :zlexeme

      # initialize(theLexeme, aTerminal, aPosition) ⇒ Token
      def initialize(literalText, aLexeme, aPosition)
        super(literalText, aLexeme.wclass.name, aPosition)
        @zlexeme = aLexeme
      end
    end # class
  end # module
end # module
