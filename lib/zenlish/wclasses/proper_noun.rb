# frozen_string_literal: true

require_relative 'noun'

module Zenlish
  module WClasses
    # Proper nouns refer to persons, places, geographical features, planets, or various
    # period of time.
    class ProperNoun < Noun
      def initialize
        super()
        init_feature_defs
      end

      def init_feature_defs
        # Override standard feature definitions for proper nouns.
        feature_def_dsl do
          feature_def 'NUMBER' => enumeration(:singular)
        end
      end
    end # class
  end # module
end # module
