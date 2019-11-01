module Zenlish
  module Lex
    # A word in the abstract sense; an individual, distinct item of a lexicon
    # that belongs to a word class and of which a number of actual word forms
    # may exist. For instance, the word forms: 'hide', 'hides', 'hid', 'hidden'
    # relate to the lexeme for verb 'hide'. Also called 'dictionary word'.
    class Lexeme
      # @return Zenlish::WClasses::WordClass
      attr_reader :wclass

      def initialize(aWordClass, anEntry)
        @wclass = aWordClass
        @entry = anEntry.object_id
        anEntry.add_lexeme(self)
      end

      # @return Zenlish::Lex::LexicalEntry
      def entry
        ObjectSpace._id2ref(@entry)
      end

      def lemma
        entry.lemma
      end
    end # class
  end # module
end # module