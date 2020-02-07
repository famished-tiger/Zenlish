require_relative 'irregular_verb'

module Zenlish
  module WClasses
    # The `have` verb used as a lexical verb (as opposed auxiliary verb).
    class IrregularVerbHave < IrregularVerb
      def initialize
        super()
      end
      
      # The mix-in module used to extend the lexeme
      # @return [Module, NilClass]
      def extension
        nil
      end      

      private

      def init_feature_defs
        super
        # Create standard feature definitions for irregular verbs.
        feature_def_dsl {
          feature_def 'PARADIGM' => [identifier, 'Verb_have_inflection'] # 2nd item is default value
        }
      end

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('Verb_have_inflection') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'TIME'
          #     PERSON              NUMBER             TIME
          rule([not_equal(:third), equals(:singular), equals(:present)         ], literal('have'))
          rule([equals(:third),    equals(:singular), equals(:present)        ], literal('has'))
          rule([dont_care,         equals(:plural),   equals(:present)        ], literal('have'))
          rule([dont_care,         dont_care,         equals(:progressive)    ], literal('having'))
          rule([dont_care,         dont_care,         equals(:past_simple)    ], literal('had'))          
          rule([dont_care,         dont_care,         equals(:past_participle)], literal('had'))
        end
        add_paradigm(table)
      end

      def add_paradigm(anInflectionTable)
        @paradigms[anInflectionTable.name] = anInflectionTable
      end    
    end # class
  end # module
end # module