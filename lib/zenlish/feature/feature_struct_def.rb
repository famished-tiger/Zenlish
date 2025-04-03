# frozen_string_literal: true

require_relative 'feature_domain'

module Zenlish
  module Feature
    class FeatureStructDef < FeatureDomain
      attr_reader :parent
      attr_reader :struct

      # @param aParent [FeatureStructDef]
      def initialize(aParent = nil)
        super()
        @parent = validated_parent(aParent)
        @struct = {}
      end

      # @param aFeatureName [String]
      def [](aFeatureName)
        return struct[aFeatureName] if struct.include? aFeatureName

        if parent
          p_struct = parent.struct
          return p_struct[aFeatureName] if p_struct.include? aFeatureName
        end

        raise StandardError, "Unknown feature name #{aFeatureName}"
      end

      # @param aFeatureDef [Zenlish::Feature::FeatureDef]
      def add_feature_def(aFeatureDef)
        struct[aFeatureDef.name] = aFeatureDef
      end

      private

      def validated_parent(aParent)
        if aParent.kind_of?(FeatureStructDef)
          aParent
        elsif aParent
          aParent.struct
        end
      end
    end # class
  end # module
end # module
