# frozen_string_literal: true

unless defined?(Zenlish::Lang::Dictionary)
  require_relative '../feature/feature_struct_def_bearer'
  module Zenlish
    module Lang
      require_relative '../lex/empty_lexicon_factory'
      require_relative '../lex/lexical_entry'
      require_relative '../lex/lexeme'

      sandbox = Object.new
      sandbox.extend(Zenlish::Lex::EmptyLexiconFactory)
      Dictionary = sandbox.create_empty_lexicon
      extend(Feature::FeatureStructDefBearer)

      # @param aLemma [String] is the canonical form, dictionary form,
      #   or citation form of a headword.
      # @param aWClassName [String] the name of a word class.
      def self.add_entry(aLemma, aWClassName, aFeatureHash = nil, &aBlock)
        entry = Zenlish::Lex::LexicalEntry.new(aLemma)
        wclass = Dictionary.name2terminal[aWClassName]
        raise StandardError, "Undefined word class for '#{aLemma}'" unless wclass

        lexeme = Zenlish::Lex::Lexeme.new(wclass, entry, aFeatureHash)
        lexeme.instance_exec(&aBlock) if block_given?
        lexeme.freeze
        Dictionary.add_entry(entry.freeze)
      end

      # Our minimalistic lexicon
      add_entry('a', 'IndefiniteArticle')
      add_entry('about', 'Preposition')
      add_entry('above', 'Preposition')
      add_entry('after', 'Adverb')
      add_entry('after', 'Preposition')
      add_entry('after', 'SubordinatingConjunction')
      add_entry('alive', 'Adjective')
      add_entry('all', 'FrontingQuantifier')
      add_entry('and', 'Coordinator')
      add_entry('animal', 'CommonNoun')
      add_entry('another', 'Adjective')
      add_entry('another', 'Pronoun')
      add_entry('as', 'ComparativeParticle')
      add_entry('at', 'Preposition')
      add_entry('bad', 'Adjective')
      add_entry('be', 'AuxiliaryBe')
      add_entry('be', 'IrregularVerbBe')
      add_entry('because', 'SubordinatingConjunction')
      add_entry('become', 'IrregularLinkingVerb') do
        forms past_simple: 'became', past_participle: 'become'
      end
      add_entry('before', 'Adverb')
      add_entry('before', 'Adjective')
      add_entry('before', 'Preposition')
      add_entry('before', 'SubordinatingConjunction')
      add_entry('belong', 'RegularVerb')
      add_entry('below', 'Preposition')
      add_entry('between', 'Preposition')
      add_entry('big', 'Adjective')
      add_entry('body', 'CommonNoun')
      add_entry('but', 'Coordinator')
      add_entry('can', 'IrregularVerbCan')
      add_entry('can', 'ModalVerbCan')
      add_entry('cause', 'RegularVerb')
      add_entry('change', 'RegularVerb')
      add_entry('choose', 'IrregularVerb') do
        forms past_simple: 'chose', past_participle: 'chosen'
      end
      add_entry('contain', 'RegularVerb')
      add_entry('container', 'CommonNoun')
      add_entry('damage', 'RegularVerb')
      add_entry('die', 'RegularVerb')
      add_entry('difficult', 'Adjective')
      add_entry('different', 'Adjective')
      add_entry('do', 'AuxiliaryDo')
      add_entry('do', 'IrregularVerbDo')
      add_entry('each', 'DistributiveDeterminer')
      add_entry('each', 'Pronoun')
      add_entry('exist', 'RegularVerb')
      add_entry('false', 'Adjective')
      add_entry('far', 'Adverb')
      add_entry('far from', 'Preposition')
      add_entry('feel', 'IrregularLinkingVerb') do
        forms past_simple: 'felt', past_participle: 'felt'
      end
      add_entry('for', 'Preposition')
      add_entry('from', 'Preposition')
      add_entry('good', 'Adjective')
      add_entry('have', 'IrregularVerbHave')
      add_entry('happen', 'RegularVerb')
      add_entry('hear', 'IrregularLinkingVerb') do
        forms past_simple: 'heard', past_participle: 'heard'
      end
      add_entry('here', 'Adverb')
      # example: ...from here (works as a pronoun of a place)
      add_entry('here', 'CommonNoun', { 'NUMBER' => enumeration(:singular),
        'PARADIGM' => [identifier, 'Singular_only'] })
      add_entry('I', 'PersonalPronoun', { 'PERSON' => enumeration(:first),
        'GENDER' => enumeration(:feminine, :masculine) })
      add_entry('if', 'SubordinatingConjunction')
      add_entry('in', 'Preposition')
      add_entry('inside', 'Preposition')
      add_entry('it', 'PersonalPronoun', { 'PERSON' => enumeration(:third),
        'PARADIGM' => [identifier, 'ppn_3rd_paradigm'] })
      add_entry('its', 'PossessiveDeterminer', { 'PERSON' => enumeration(:third),
        'PARADIGM' => [identifier, 'possdet_3rd_paradigm'] })
      add_entry('kind', 'CommonNoun')
      add_entry('know', 'IrregularVerbKnow') do
        forms past_simple: 'knew', past_participle: 'known'
      end
      add_entry('like', 'Preposition')
      add_entry('live', 'RegularVerb')
      add_entry('living', 'Adjective')
      add_entry('long', 'Adjective')
      add_entry('machine', 'CommonNoun')
      add_entry('make', 'IrregularVerb') do
        forms past_simple: 'made', past_participle: 'made'
      end
      add_entry('many', 'Quantifier')
      add_entry('maybe', 'AdverbMaybe')
      add_entry('moment', 'CommonNoun')
      add_entry('more', 'Adjective')
      add_entry('more', 'Adverb')
      add_entry('move', 'RegularVerb')
      add_entry('much', 'Adverb')
      add_entry('my', 'PossessiveDeterminer', { 'PERSON' => enumeration(:first),
        'GENDER' => enumeration(:feminine, :masculine) })
      add_entry('near', 'Preposition')
      add_entry('near to', 'Preposition')
      add_entry('now', 'Adverb')
      add_entry('now', 'CommonNoun', { 'NUMBER' => enumeration(:singular),
        'PARADIGM' => [identifier, 'Singular_only'] })
      add_entry('not', 'AdverbNot')
      add_entry('of', 'PrepositionOf')
      add_entry('on', 'Preposition')
      add_entry('one', 'Adjective')
      add_entry('one', 'Cardinal')
      add_entry('one', 'IndefinitePronoun')
      add_entry('or', 'Coordinator')
      add_entry('other', 'Adjective')
      add_entry('part', 'CommonNoun')
      add_entry('people', 'CommonNoun', { 'NUMBER' => enumeration(:plural),
        'PARADIGM' => [identifier, 'Plural_only'] })
      add_entry('person', 'CommonNoun', { 'NUMBER' => enumeration(:singular),
        'PARADIGM' => [identifier, 'Singular_only'] })
      add_entry('place', 'CommonNoun')
      add_entry('same', 'Adjective')
      add_entry('same', 'Pronoun')
      add_entry('say', 'IrregularVerbSay') do
        forms past_simple: 'said', past_participle: 'said'
      end
      add_entry('see', 'IrregularVerb') do
        forms past_simple: 'saw', past_participle: 'seen'
      end
      add_entry('short', 'Adjective')
      add_entry('side', 'CommonNoun')
      add_entry('small', 'Adjective')
      add_entry('some', 'Quantifier')
      add_entry('someone', 'IndefinitePronoun')
      add_entry('someplace', 'Adverb')
      add_entry('something', 'IndefinitePronoun')
      add_entry('surface', 'CommonNoun')
      add_entry('than', 'PrepositionThan')
      add_entry('that', 'RelativePronoun')
      add_entry('the', 'DefiniteArticle')
      add_entry('then', 'LinkingAdverb')
      add_entry('there', 'ExistentialThere')
      add_entry('thing', 'CommonNoun')
      add_entry('think', 'IrregularVerbThink') do
        forms past_simple: 'thought', past_participle: 'thought'
      end
      add_entry('this', 'DemonstrativeDeterminer')
      add_entry('this', 'DemonstrativePronoun')
      add_entry('this one', 'DemonstrativePronoun')
      add_entry('time', 'CommonNoun')
      add_entry('to', 'Preposition')
      add_entry('touch', 'RegularVerb')
      add_entry('try', 'RegularVerb')
      add_entry('true', 'Adjective')
      add_entry('two', 'Cardinal')
      add_entry('two', 'IndefinitePronoun')
      add_entry('use', 'RegularVerb')
      add_entry('very', 'DegreeAdverb')
      add_entry('want', 'RegularVerbWant')
      add_entry('what', 'ConjunctivePronoun')
      add_entry('when', 'SubordinatingConjunction')
      add_entry('where', 'Adverb')
      add_entry('where', 'SubordinatingConjunction')
      add_entry('who', 'RelativePronoun')
      add_entry('with', 'Preposition')
      add_entry('word', 'CommonNoun')
      add_entry('you', 'PersonalPronoun', { 'PERSON' => enumeration(:second),
            'GENDER' => enumeration(:feminine, :masculine),
            'PARADIGM' => [identifier, 'ppn_2nd_paradigm'] })
      add_entry('your', 'PossessiveDeterminer', { 'PERSON' => enumeration(:second),
        'GENDER' => enumeration(:feminine, :masculine),
        'PARADIGM' => [identifier, 'possdet_2nd_paradigm'] })

      # Punctuation signs...
      add_entry(':', 'Colon')
      add_entry(',', 'Comma')
      add_entry('.', 'Period')
      add_entry('"', 'Quote')
    end # module
  end # module
end # defined?
