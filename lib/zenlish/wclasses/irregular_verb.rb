require_relative 'lexical_verb'

module Zenlish
  module WClasses
    class IrregularVerb < LexicalVerb
      # @return [Array<String>]  [the past simple form, past participle form].
      attr_writer :forms

      def initialize
        super()
        init_feature_defs
      end

      def past_simple
        raise StandardError
      end

      def past_participle
        raise StandardError
      end

      private

      def init_feature_defs
        super()
        # Define standard feature definitions for irregular verbs.
        feature_def_dsl {
          feature_def 'PARADIGM' => [identifier, 'Irregular_form'] # 2nd item is default value
        }
      end
    end # class
  end # module
end # module