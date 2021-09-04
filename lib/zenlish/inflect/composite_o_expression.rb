# frozen_string_literal: true

require_relative 'output_expression'

module Zenlish
  module Inflect
    class CompositeOExpression < OutputExpression
      attr_reader :children

      def initialize(theChildren)
        super()
        @children = theChildren.dup
      end
    end # class
  end # module
end # module
