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
        aValue =~ /^[a-zA-Z\_][a-zA-Z0-9\_]*$/
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
