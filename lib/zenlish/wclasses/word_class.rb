# frozen_string_literal: true

require 'rley'
require_relative '../feature/feature_struct_def_bearer'

module Zenlish
  module WClasses
    # Also known as: part of speech, syntactic category or word category.
    # A word class represents a group of word which have similar functions.
    # Word classes are divided into:
    # - Lexical words (?? same as content words??) such as nouns, verbs, adjectives,
    #   adverbs. Content words carry the meaning of a sentence for the chosen discourse
    #   universe.
    #
    # - Function words (?? same as structure words??) such as pronouns, determiners,
    #   modal verbs, auxiliary verbs. Structure words helpt to structure a sentence.
    #   They working is independent of the chosen discourse universe.
    #   conjunctions and prepositions
    class WordClass < Rley::Syntax::Terminal
      include Feature::FeatureStructDefBearer
      # @return [Hash] pair of the kind: String => InflectionTable
      attr_reader :paradigms

      def initialize
        super(self.class.name.split('::').last)
        init_struct_def(nil, {})
        @paradigms = {}
      end

      # Indicates whether all words from the word class have a single (uninflected)
      # form.
      # @return [FalseClass, TrueClass] true iff the words in the class are invariable.
      def invariable?
        true
      end

      # @return [Module, NilClass]
      def extension
        nil
      end

      protected

      def add_paradigm(anInflectionTable)
        @paradigms[anInflectionTable.name] = anInflectionTable
      end
    end # class
  end # module
end # module
