require_relative 'auxiliary'

module Zenlish
  module WClasses
    # TODO: document
    class AuxiliaryDo < Auxiliary
      def initialize
        super()
      end

      private

      def init_feature_defs
        super
        # Create standard feature definitions for modal verb can.
        feature_def_dsl {
          feature_def 'PARADIGM' => [identifier, 'Verb_do_inflection'] # 2nd item is default value
        }
      end

      def init_paradigms
        builder = Inflect::InflectionTableBuilder.new
        table = builder.build('Verb_do_inflection') do
          feature_heading 'PERSON'
          feature_heading 'NUMBER'
          feature_heading 'TIME'
          #     PERSON              NUMBER             TIME
          rule([not_equal(:third), equals(:singular), equals(:present)        ], literal('do'))
          rule([equals(:third),    equals(:singular), equals(:present)        ], literal('does'))
          rule([dont_care,         equals(:plural),   equals(:present)        ], literal('do'))
          rule([dont_care,         dont_care,         equals(:progressive)    ], literal('doing'))
          rule([dont_care,         dont_care,         equals(:past_simple)    ], literal('did'))
          rule([dont_care,         dont_care,         equals(:past_participle)], literal('done'))
        end
        add_paradigm(table)
      end
    end # class
  end # module
end # module
