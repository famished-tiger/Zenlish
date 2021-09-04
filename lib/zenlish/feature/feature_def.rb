# frozen_string_literal: true

require_relative 'boolean_domain'
require_relative 'enumeration_domain'
require_relative 'feature_value'

module Zenlish
  module Feature
    class FeatureDef
      # @return [String] the name of the feature
      attr_reader :name

      # @return [FeatureDomain] the set of potential values the feature can take
      attr_reader :domain

      # @return [FeatureValue] the default value for the feature.
      attr_reader :default

      # @param aName [String] the name of the feature
      # @param aDomain [FeatureDomain]
      # @param aDefault [FeatureValue, NilClass]
      def initialize(aName, aDomain, aDefault = nil)
        @name = validated_name(aName)
        @domain = aDomain
        @default = validated_default(domain, aDefault)
      end

      private

      def validated_name(aName)
        raise StandardError, 'feature name cannot be empty.' if aName.empty?

        aName.dup
      end

      def validated_default(aDomain, aDefault)
        if aDefault
          @default = aDefault
        elsif aDomain.is_a?(BooleanDomain)
          @default = nil
        elsif aDomain.is_a?(EnumerationDomain)
          if aDomain.enum.size == 1
            val = FeatureValue.new(aDomain.enum[0])
            @default = val
          else
            @default = nil
          end
        end
      end
    end # class
  end # module
end # module
