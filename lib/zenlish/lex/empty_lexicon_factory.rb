require_relative '../wclasses/all_word_classes'
require_relative 'lexicon'

module Zenlish
  module Lex
    module EmptyLexiconFactory
      def create_empty_lexicon()
        lexicon = Lexicon.new

        add_word_classes(lexicon)
        add_punctuation(lexicon)
        lexicon
      end

      private

      def add_word_classes(aLexicon)
        aLexicon.add_terminal(WClasses::CommonNoun.new)
        aLexicon.add_terminal(WClasses::ProperNoun.new)
        aLexicon.add_terminal(WClasses::IrregularVerb.new)
        aLexicon.add_terminal(WClasses::Adjective.new)
        aLexicon.add_terminal(WClasses::DefiniteArticle.new)
        aLexicon.add_terminal(WClasses::DemonstrativeDeterminer.new)
        aLexicon.add_terminal(WClasses::IndefinitePronoun.new)
      end

      def add_punctuation(aLexicon)
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Period'))
      end
    end # module
  end # module
end # module
