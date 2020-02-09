require_relative 'auxiliary'

module Zenlish
  module WClasses
    class AuxiliaryBe < Auxiliary
      def initialize
        super()
      end

      private

      def init_feature_defs
        super
        # Create standard feature definitions for modal verb can.
        feature_def_dsl {
          feature_def 'PARADIGM' => [identifier, 'Verb_be_inflection'] # 2nd item is default value
        }
      end

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('Verb_be_inflection') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'TIME'
          #     PERSON               NUMBER             TIME
          rule([equals(:first),      equals(:singular), equals(:present)        ], literal('am'))
          rule([equals(:second),     equals(:singular), equals(:present)        ], literal('are'))
          rule([equals(:third),      equals(:singular), equals(:present)        ], literal('is'))
          rule([dont_care,           equals(:plural),   equals(:present)        ], literal('are'))
          rule([dont_care,           dont_care,         equals(:progressive)    ], literal('being'))
          rule([in?(:first, :third), equals(:singular), equals(:past_simple)    ], literal('was'))
          rule([equals(:second),     equals(:singular), equals(:past_simple)    ], literal('were'))
          rule([dont_care,           equals(:plural),   equals(:past_simple)    ], literal('were'))
          rule([dont_care,           dont_care,         equals(:past_participle)], literal('been'))
        end
        add_paradigm(table)
      end    
    end # class
  end # module
end # module
