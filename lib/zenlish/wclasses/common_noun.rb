require_relative 'noun'
require_relative '../inflect/inflection_table_builder'

module Zenlish
  module WClasses
    # Common nouns refer to general entities. Most have a singular and plural form.
    class CommonNoun < Noun
      def initialize
        super
        @paradigms = {}
        init_paradigms
      end

      # @return [Inflection::InflectionTable] Return default paradigm
      def paradigm
        paradigm_feat_def = self['PARADIGM']
        paradigms[paradigm_feat_def.default.val]
      end

      private

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new

        table = builder.build('Common_form') do
          feature_heading 'NUMBER'
          method_heading 'base_form'
          rule([equals(:singular), dont_care], col('base_form'))
          rule([equals(:plural), matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
          rule([equals(:plural), dont_care], concat(col('base_form'), 's'))
        end
        add_paradigm(table)

        table = builder.build('Plural_only') do
          feature_heading 'NUMBER'
          method_heading 'base_form'
          rule([equals(:plural), dont_care], col('base_form'))
        end
        add_paradigm(table)

        table = builder.build('Singular_only') do
          feature_heading 'NUMBER'
          method_heading 'base_form'
          rule([equals(:singular), dont_care], col('base_form'))
        end
        add_paradigm(table)
      end

      def add_paradigm(anInflectionTable)
        @paradigms[anInflectionTable.name] = anInflectionTable
      end
    end # class
  end # module
end # module
