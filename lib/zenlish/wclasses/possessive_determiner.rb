require_relative 'determiner'
require_relative '../inflect/inflection_table_builder'

module Zenlish
  module WClasses
    # Possessive determiner (aka possessive adjective) is a class of determiner,
    # that is used to modify nouns to denote possession my, your, her, his, its.
    # they aren't used with other determiners like the, a/an, or this.
    class PossessiveDeterminer < Determiner
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
        feature_def_dsl {
          feature_def 'NUMBER' => enumeration(:singular, :plural)
          feature_def 'PERSON' => enumeration(:first, :second, :third)
          feature_def 'GENDER' => enumeration(:feminine, :masculine, :neuter)
          feature_def 'PARADIGM' => [identifier, 'possdet_1st_paradigm'] # 2nd item is default value
        }
      end

      def init_paradigms
        # Conventional base forms in Zenlish are: my, your, its
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('possdet_1st_paradigm') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'GENDER'
          #     PERSON          NUMBER             GENDER             
          rule([equals(:first), equals(:singular), not_equal(:neuter)], func('base_form'))
          rule([equals(:first), equals(:plural),   not_equal(:neuter)], literal('our'))
        end
        add_paradigm(table)

        table = builder.build('possdet_2nd_paradigm') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'GENDER'
          #     PERSON           NUMBER     GENDER             
          rule([equals(:second), dont_care, not_equal(:neuter)],  func('base_form'))

        end
        add_paradigm(table)
        
        table = builder.build('possdet_3rd_paradigm') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'GENDER'
          #     PERSON          NUMBER             GENDER             
          rule([equals(:third), equals(:singular), equals(:neuter)],    func('base_form'))
          rule([equals(:third), equals(:singular), equals(:feminine)],  literal('her'))
          rule([equals(:third), equals(:singular), equals(:masculine)], literal('his'))
          rule([equals(:third), equals(:plural), dont_care],            literal('their'))           
        end
        add_paradigm(table)        
      end   
    end # class
  end # module
end # module
