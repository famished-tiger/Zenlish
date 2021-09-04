# frozen_string_literal: true

require_relative 'heading'

module Zenlish
  module Inflect
    class FeatureHeading < Heading
      def evaluate_for(aFeatureBearer)
        aFeatureBearer[label]
      end

      def all_matches(aFeatureBearer)
        feat = aFeatureBearer[label]
        if feat.kind_of?(Feature::FeatureDef)
          feat.domain.to_a
        else
          [feat]
        end
      end
    end # class
  end # module
end # module
