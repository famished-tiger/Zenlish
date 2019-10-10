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
        aLexicon.add_terminal(WClasses::Adjective.new.freeze)
        aLexicon.add_terminal(WClasses::Cardinal.new.freeze)
        aLexicon.add_terminal(WClasses::CommonNoun.new.freeze)
        aLexicon.add_terminal(WClasses::ComparativeParticle.new.freeze)
        aLexicon.add_terminal(WClasses::DefiniteArticle.new.freeze)
        aLexicon.add_terminal(WClasses::DemonstrativeDeterminer.new.freeze)
        aLexicon.add_terminal(WClasses::IndefinitePronoun.new.freeze)
        aLexicon.add_terminal(WClasses::IrregularVerb.new.freeze)
        aLexicon.add_terminal(WClasses::ProperNoun.new.freeze)
      end

      def add_punctuation(aLexicon)
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Period'))
      end
    end # module
  end # module
end # module
