# frozen_string_literal: true

require_relative 'feature_value'
require_relative 'feature'

module Zenlish
  module Feature
    class FeatureStruct < FeatureValue
      def initialize(aStructDef)
        featrs = build_features(aStructDef)
        super(aStructDef, featrs)
      end

      private

      def build_features(aStructDef)
        feats = []
        aStructDef.struct.each_value do |feature_def|
          feats << Feature.new(feature_def)
        end

        feats
      end
    end # class
  end # module
end # module
