module Zenlish
  module Lex
    # TODO: document
    class Lexeme
      # @return Zenlish::WClasses::WordClass
      attr_reader :wclass
      
      # @return Zenlish::Lex::LexicalEntry
      attr_reader :entry

      def initialize(aWordClass, anEntry)
        @wclass = aWordClass
        @entry = anEntry
        @entry.add_lexeme(self)
      end

      def lemma
        entry.lemma
      end
    end # class
  end # module
end # module