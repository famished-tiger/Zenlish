# frozen_string_literal: true

require_relative 'heading'

module Zenlish
  module Inflect
    class MethodHeading < Heading
      def evaluate_for(aFeatureBearer)
        aFeatureBearer.send(label)
      end

      def all_matches(aFeatureBearer)
        [evaluate_for(aFeatureBearer)]
      end
    end # class
  end # module
end # module
