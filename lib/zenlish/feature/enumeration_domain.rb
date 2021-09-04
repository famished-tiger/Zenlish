# frozen_string_literal: true

require_relative 'feature_domain'
require_relative 'symbol_value'

module Zenlish
  module Feature
    class EnumerationDomain < FeatureDomain
      attr_reader :enum

      def initialize(*symbols)
        super()
        @enum = symbols
      end

      def build_value(aValue)
        SymbolValue.new(validated_value(aValue))
      end

      def include?(aValue)
        enum.include?(aValue)
      end

      def to_a
        enum
      end

      private

      def validated_value(aValue)
        unless include?(aValue)
           raise StandardError, "#{aValue} isn't part of enumeration [#{enum.join(', ')}]."
        end

        aValue
      end
    end # class
  end # module
end # module
