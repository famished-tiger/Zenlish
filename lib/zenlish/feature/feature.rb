# frozen_string_literal: true

require 'forwardable'

module Zenlish
  module Feature
    class Feature
      # Forwardable mix-in module to implement delegation of specified methods.
      extend Forwardable

      # The feature definition
      attr_reader :definition

      attr_reader :binding

      def_delegators :@definition, :name, :domain

      # @param aDefinition [FeatureDef]
      def initialize(aDefinition)
        @definition = aDefinition
      end

      def bound?
        !binding.nil?
      end

      def bind_to(aFeatureValue)
        @binding = aFeatureValue
      end
    end # class
  end # module
end # module
