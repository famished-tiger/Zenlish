require 'singleton'
require_relative 'feature_domain'
require_relative 'boolean_value'

module Zenlish
  module Feature
    class BooleanDomain < FeatureDomain
      include Singleton # Use the Singleton design patttern
      
      def build_value(aValue)
        BooleanValue.new(validated_value(aValue))
      end
      
      def include?(aValue)
        aValue.kind_of?(TrueClass) || aValue.kind_of?(FalseClass)
      end
      
      def to_a
        [false, true]
      end

      private

      def validated_value(aValue)
        if not aValue.is_a?(FalseClass) and not aValue.is_a?(TrueClass)
           raise StandardError, "Expected a boolean instead of #{aValue.class}."
        end

        aValue
      end
    end # class
  end # module
end # module
