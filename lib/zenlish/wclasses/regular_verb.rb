require_relative 'lexical_verb'

module Zenlish
  module WClasses
    class RegularVerb < LexicalVerb
      def initialize
        super
      end

      private

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('Regular_inflection') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'TIME'
          method_heading  'base_form'
          #     PERSON             NUMBER             TIME                         base_form
          rule([not_equal(:third), dont_care,         equals(:present),            dont_care], col('base_form'))
          rule([equals(:third),    equals(:singular), equals(:present),            matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
          rule([equals(:third),    equals(:singular), equals(:present),            matches(/(?:[osxz]|ch|sh)$/)], concat(col('base_form'), 'es'))             
          rule([equals(:third),    equals(:singular), equals(:present),            dont_care], concat(col('base_form'), 's'))         
          rule([dont_care,         dont_care,         equals(:progressive),        matches(/ie$/)], sub(col('base_form'), /ie$/, 'ying'))          
          rule([dont_care,         dont_care,         equals(:progressive),        matches(/[^eoy]e$/)], sub(col('base_form'), /e$/, 'ing'))            
          rule([dont_care,         dont_care,         equals(:progressive),        dont_care], concat(col('base_form'), 'ing'))
          rule([dont_care,         dont_care, in?(:past_simple, :past_participle), matches(/e$/)], concat(col('base_form'), 'd'))             
          rule([dont_care,         dont_care, in?(:past_simple, :past_participle), matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ied'))            
          rule([dont_care,         dont_care, in?(:past_simple, :past_participle), dont_care], concat(col('base_form'), 'ed'))
        end
        add_paradigm(table)
      end
    end # class
  end # module
end # module