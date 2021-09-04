# frozen_string_literal: true

require_relative 'determiner'
require_relative '../inflect/inflection_table_builder'

module Zenlish
  module WClasses
    # In grammar, a demonstrative is a determiner or a pronoun
    # that points to a particular noun or to the noun it replaces (the antecedent).
    class DemonstrativeDeterminer < Determiner
      def initialize
        super()
        init_feature_defs
        init_paradigms
      end

      # @return [FalseClass] Indicates that demonstrative determiners inflects.
      def invariable?
        false
      end

      private

      def init_feature_defs
        # Create standard feature definitions for irregular verbs.
        feature_def_dsl do
          feature_def 'NUMBER' => enumeration(:singular, :plural)
          feature_def 'DISTANCE' => enumeration(:near, :far)
          feature_def 'PARADIGM' => [identifier, 'Demonstrative_det_paradigm'] # 2nd item is default value
        end
      end

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('Demonstrative_det_paradigm') do
          feature_heading 'NUMBER'
          feature_heading 'DISTANCE'
          #     NUMBER             DISTANCE
          rule([equals(:singular), equals(:near)],  func('base_form'))
          rule([equals(:singular), equals(:far)],   literal('that'))
          rule([equals(:plural),   equals(:near)],  literal('these'))
          rule([equals(:plural),   equals(:far)],   literal('those'))
        end
        add_paradigm(table)
      end
    end # class
  end # module
end # module
