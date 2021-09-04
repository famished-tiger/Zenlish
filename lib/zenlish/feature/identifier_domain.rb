# frozen_string_literal: true

require 'singleton'
require_relative 'feature_domain'
require_relative 'identifier_value'

module Zenlish
  module Feature
    class IdentifierDomain < FeatureDomain
      include Singleton # Use the ingletion design pattern

      def build_value(aValue)
        IdentifierValue.new(validated_value(aValue))
      end

      def include?(aValue)
        aValue =~ /^[a-zA-Z_][a-zA-Z0-9_]*$/
      end

      private

      def validated_value(aValue)
        unless include?(aValue)
           raise StandardError, "#{aValue} isn't a valid identifier."
        end

        aValue
      end
    end # class
  end # module
end # module
