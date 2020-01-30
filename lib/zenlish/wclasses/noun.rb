require_relative 'word_class'

module Zenlish
  module WClasses
    # A noun denotes classes and categories of things in the unverse of discourse.
    # Nouns denote people, animals, inanimate things, places, events, qualities
    # and states.
    class Noun < WordClass
      def initialize
        super()
        init_feature_defs
      end

      # Nouns inflect according to number, possessive. Therefore they are
      # variable.
      def invariable?
        false
      end

      private

      def init_feature_defs
        # Create standard feature definitions for nouns.
        feature_def_dsl {
          feature_def 'NUMBER' => enumeration(:singular, :plural)
          feature_def 'COUNTABILITY' => enumeration(:count, :non_count)
          feature_def 'PARADIGM' => [identifier, 'Common_form'] # 2nd item is default value
        }
      end
    end # class
  end # module
end # module
