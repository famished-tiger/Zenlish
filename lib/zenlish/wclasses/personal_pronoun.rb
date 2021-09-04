# frozen_string_literal: true

require_relative 'pronoun'
require_relative '../inflect/inflection_table_builder'

module Zenlish
  module WClasses
    # Personal pronouns refer to people or things involved in the text.
    # They change according to person, number, gender and case.
    # Subject forms: I, you, he/she/it, we, you, they
    # Object forms: Me, you, him, her, it, us, you, them
    class PersonalPronoun < Pronoun
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
          feature_def 'PERSON' => enumeration(:first, :second, :third)
          feature_def 'GENDER' => enumeration(:feminine, :masculine, :neuter)
          feature_def 'CASE' => enumeration(:subject, :object)
          feature_def 'PARADIGM' => [identifier, 'ppn_1st_paradigm'] # 2nd item is default value
        end
      end

      def init_paradigms
        # Conventional base forms in Zenlish are: I, you, it
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('ppn_1st_paradigm') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'GENDER'
          feature_heading 'CASE'
          #     PERSON          NUMBER             GENDER              CASE
          rule([equals(:first), equals(:singular), not_equal(:neuter), equals(:subject)], func('base_form'))
          rule([equals(:first), equals(:plural),   not_equal(:neuter), equals(:subject)], literal('we'))
          rule([equals(:first), equals(:singular), not_equal(:neuter), equals(:object)],  literal('me'))
          rule([equals(:first), equals(:plural),   not_equal(:neuter), equals(:object)],  literal('us'))
        end
        add_paradigm(table)

        table = builder.build('ppn_2nd_paradigm') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'GENDER'
          feature_heading 'CASE'
          #     PERSON           NUMBER     GENDER              CASE
          rule([equals(:second), dont_care, not_equal(:neuter), dont_care], func('base_form'))
        end
        add_paradigm(table)

        table = builder.build('ppn_3rd_paradigm') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'GENDER'
          feature_heading 'CASE'
          #     PERSON          NUMBER             GENDER              CASE
          rule([equals(:third), equals(:singular), equals(:neuter),    dont_care],         func('base_form'))
          rule([equals(:third), equals(:singular), equals(:feminine),  equals(:subject)],  literal('she'))
          rule([equals(:third), equals(:singular), equals(:masculine), equals(:subject)],  literal('he'))
          rule([equals(:third), equals(:plural),   dont_care,          equals(:subject)],  literal('they'))
          rule([equals(:third), equals(:singular), equals(:feminine),  equals(:object)],   literal('her'))
          rule([equals(:third), equals(:singular), equals(:masculine), equals(:object)],   literal('him'))
          rule([equals(:third), equals(:plural),   dont_care,          equals(:object)],   literal('them'))
        end
        add_paradigm(table)
      end
    end # class
  end # module
end # module
