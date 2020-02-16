require_relative '../wclasses/all_word_classes'
require_relative 'lexicon'

module Zenlish
  module Lex
    module EmptyLexiconFactory
      # Factory method. Helps in creating an "empty" lexicon.
      # It just contains the word classes of Zenlish but no headwords.
      # @return [Lexicon] the created lexicon object
      def create_empty_lexicon()
        lexicon = Lexicon.new

        add_word_classes(lexicon)
        add_punctuation(lexicon)
        lexicon
      end

      private

      def add_word_classes(aLexicon)
        add_wclass(aLexicon, WClasses::Adjective)
        add_wclass(aLexicon, WClasses::Adverb)
        add_wclass(aLexicon, WClasses::AdverbMaybe)
        add_wclass(aLexicon, WClasses::AdverbNot)
        add_wclass(aLexicon, WClasses::AuxiliaryBe)
        add_wclass(aLexicon, WClasses::AuxiliaryDo)
        add_wclass(aLexicon, WClasses::Cardinal)
        add_wclass(aLexicon, WClasses::CommonNoun)
        add_wclass(aLexicon, WClasses::ComparativeParticle)
        add_wclass(aLexicon, WClasses::ConjunctivePronoun)
        add_wclass(aLexicon, WClasses::Coordinator)
        add_wclass(aLexicon, WClasses::DefiniteArticle)
        add_wclass(aLexicon, WClasses::DegreeAdverb)
        add_wclass(aLexicon, WClasses::DemonstrativeDeterminer)
        add_wclass(aLexicon, WClasses::DemonstrativePronoun)
        add_wclass(aLexicon, WClasses::DistributiveDeterminer)
        add_wclass(aLexicon, WClasses::ExistentialThere)
        add_wclass(aLexicon, WClasses::FrontingQuantifier)
        add_wclass(aLexicon, WClasses::IndefiniteArticle)
        add_wclass(aLexicon, WClasses::IndefinitePronoun)
        add_wclass(aLexicon, WClasses::IrregularLinkingVerb)
        add_wclass(aLexicon, WClasses::IrregularVerb)
        add_wclass(aLexicon, WClasses::IrregularVerbBe)
        add_wclass(aLexicon, WClasses::IrregularVerbCan)
        add_wclass(aLexicon, WClasses::IrregularVerbDo)
        add_wclass(aLexicon, WClasses::IrregularVerbHave)
        add_wclass(aLexicon, WClasses::IrregularVerbKnow)
        add_wclass(aLexicon, WClasses::IrregularVerbSay)
        add_wclass(aLexicon, WClasses::IrregularVerbThink)
        add_wclass(aLexicon, WClasses::LinkingAdverb)
        add_wclass(aLexicon, WClasses::ModalVerbCan)
        add_wclass(aLexicon, WClasses::PersonalPronoun)
        add_wclass(aLexicon, WClasses::PossessiveDeterminer)
        add_wclass(aLexicon, WClasses::Preposition)
        add_wclass(aLexicon, WClasses::PrepositionOf)
        add_wclass(aLexicon, WClasses::PrepositionThan)
        add_wclass(aLexicon, WClasses::Pronoun)
        add_wclass(aLexicon, WClasses::Quantifier)
        add_wclass(aLexicon, WClasses::RegularVerb)
        add_wclass(aLexicon, WClasses::RegularVerbWant)
        add_wclass(aLexicon, WClasses::RelativePronoun)
        add_wclass(aLexicon, WClasses::ProperNoun)
        add_wclass(aLexicon, WClasses::SubordinatingConjunction)
      end

      def add_punctuation(aLexicon)
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Colon'))
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Comma'))
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Period'))
        aLexicon.add_terminal(Rley::Syntax::Terminal.new('Quote'))
      end

      def add_wclass(aLexicon, aClass)
        aLexicon.add_terminal(aClass.new.freeze)
      end

    end # module
  end # module
end # module
