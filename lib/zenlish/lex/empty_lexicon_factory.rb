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
        aLexicon.add_terminal(WClasses::Adverb.new.freeze)
        aLexicon.add_terminal(WClasses::AdverbNot.new.freeze)
        aLexicon.add_terminal(WClasses::AdverbThere.new.freeze)
        aLexicon.add_terminal(WClasses::AuxiliaryBe.new.freeze)
        aLexicon.add_terminal(WClasses::AuxiliaryDo.new.freeze)
        aLexicon.add_terminal(WClasses::Cardinal.new.freeze)
        aLexicon.add_terminal(WClasses::CommonNoun.new.freeze)
        aLexicon.add_terminal(WClasses::ComparativeParticle.new.freeze)
        aLexicon.add_terminal(WClasses::DefiniteArticle.new.freeze)
        aLexicon.add_terminal(WClasses::IndefiniteArticle.new.freeze)
        aLexicon.add_terminal(WClasses::DegreeAdverb.new.freeze)
        aLexicon.add_terminal(WClasses::DemonstrativeDeterminer.new.freeze)
        aLexicon.add_terminal(WClasses::ConjunctivePronoun.new.freeze)
        aLexicon.add_terminal(WClasses::DemonstrativePronoun.new.freeze)
        aLexicon.add_terminal(WClasses::IndefinitePronoun.new.freeze)
        aLexicon.add_terminal(WClasses::IrregularVerb.new.freeze)
        aLexicon.add_terminal(WClasses::IrregularVerbBe.new.freeze)
        aLexicon.add_terminal(WClasses::IrregularVerbDo.new.freeze)
        aLexicon.add_terminal(WClasses::IrregularVerbHave.new.freeze)
        aLexicon.add_terminal(WClasses::IrregularVerbSay.new.freeze)
        aLexicon.add_terminal(WClasses::LinkingAdverb.new.freeze)
        aLexicon.add_terminal(WClasses::ModalVerbCan.new.freeze)
        aLexicon.add_terminal(WClasses::Preposition.new.freeze)
        aLexicon.add_terminal(WClasses::PrepositionOf.new.freeze)
        aLexicon.add_terminal(WClasses::PrepositionThan.new.freeze)
        aLexicon.add_terminal(WClasses::RegularVerb.new.freeze)
        aLexicon.add_terminal(WClasses::RegularVerbWant.new.freeze)
        aLexicon.add_terminal(WClasses::ProperNoun.new.freeze)
        aLexicon.add_terminal(WClasses::IndefiniteQuantifier.new.freeze)
        aLexicon.add_terminal(WClasses::SubordinatingConjunction.new.freeze)
      end

      def add_punctuation(aLexicon)
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Colon'))
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Comma'))
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Period'))
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Quote'))
      end
    end # module
  end # module
end # module
