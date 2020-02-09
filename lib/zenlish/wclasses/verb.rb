require_relative 'word_class'
require_relative '../inflect/inflection_table_builder'

module Zenlish
  module WClasses
    # Abstract class. In traditional grammar, the verb is often defined
    # notionally as a 'doing' word (i.e. a word that describes the action
    # in a clause).
    class Verb < WordClass
      def initialize
        super()
        @paradigms = {}
        init_feature_defs
        init_paradigms
      end

      # As all verbs inflect, or change form, to reflect changes in tense,
      # person, number, and voice, they are, by definition, variable.
      def invariable?
        false
      end

      protected

      def add_paradigm(anInflectionTable)
        @paradigms[anInflectionTable.name] = anInflectionTable
      end

      private

      def init_feature_defs
        # Create standard feature definitions for lexical verbs.
        feature_def_dsl {
          feature_def 'NUMBER' => enumeration(:singular, :plural)
          feature_def 'PERSON' => enumeration(:first, :second, :third)
          feature_def 'TIME' => enumeration(:present, :progressive, :past_simple, :past_participle)
          feature_def 'PARADIGM' => [identifier, 'Regular_inflection'] # 2nd item is default value
        }
      end

      def init_paradigms
        raise NotImplementedError, "Method #{__callee__} must implemented for #{self.class}."
      end
    end # class
  end # module
end # module