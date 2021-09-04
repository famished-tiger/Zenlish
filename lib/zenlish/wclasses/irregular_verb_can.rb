# frozen_string_literal: true

require_relative 'irregular_verb'

module Zenlish
  module WClasses
    # Irregular verb can
    class IrregularVerbCan < IrregularVerb
      # rubocop: disable Layout/SpaceInsideArrayLiteralBrackets

      private

      def init_feature_defs
        super
        # Create standard feature definitions for modal verb can.
        feature_def_dsl do
          feature_def 'TIME' => enumeration(:present, :past_simple)
          feature_def 'PARADIGM' => [identifier, 'Verb_can_inflection'] # 2nd item is default value
        end
      end

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('Verb_can_inflection') do
          feature_heading 'TIME'
          #     TIME
          rule([equals(:present)     ], literal('can'))
          rule([equals(:past_simple) ], literal('could'))
        end
        add_paradigm(table)
      end
      # rubocop: enable Layout/SpaceInsideArrayLiteralBrackets
    end # class
  end # module
end # module
