# frozen_string_literal: true

require_relative 'lexical_verb'
require_relative 'irregular_verb_extension'

module Zenlish
  module WClasses
    class IrregularVerb < LexicalVerb
      # @return [Array<String>]  [the past simple form, past participle form].
      attr_writer :forms

      # The mix-in module used to extend the lexeme
      # @return [Module, NilClass]
      def extension
        IrregularVerbExtension
      end

      private

      def init_feature_defs
        super
        # Create standard feature definitions for irregular verbs.
        feature_def_dsl do
          feature_def 'PARADIGM' => [identifier, 'Irregular_inflection'] # 2nd item is default value
        end
      end

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('Irregular_inflection') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'TIME'
          method_heading  'base_form'
          #     PERSON             NUMBER             TIME                      base_form
          rule([not_equal(:third), equals(:singular), equals(:present),         dont_care], col('base_form'))
          rule([equals(:third),    equals(:singular), equals(:present),         matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
          rule([equals(:third),    equals(:singular), equals(:present),         matches(/(?:[osxz]|ch|sh)$/)], concat(col('base_form'), 'es'))
          rule([equals(:third),    equals(:singular), equals(:present),         dont_care], concat(col('base_form'), 's'))
          rule([dont_care,         equals(:plural),   equals(:present),         dont_care], col('base_form'))
          rule([dont_care,         dont_care,         equals(:progressive),     matches(/ie$/)], sub(col('base_form'), /ie$/, 'ying'))
          rule([dont_care,         dont_care,         equals(:progressive),     matches(/[^eoy]e$/)], sub(col('base_form'), /e$/, 'ing'))
          rule([dont_care,         dont_care,         equals(:progressive),     dont_care], concat(col('base_form'), 'ing'))
          rule([dont_care,         dont_care,         equals(:past_simple),     dont_care], func('past_simple'))
          rule([dont_care,         dont_care,         equals(:past_participle), dont_care], func('past_participle'))
        end
        add_paradigm(table)
      end
    end # class
  end # module
end # module
