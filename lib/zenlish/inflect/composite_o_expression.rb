require_relative 'output_expression'

module Zenlish
  module Inflect
    class CompositeOExpression < OutputExpression
      attr_reader :children

      def initialize(theChildren)
        @children = theChildren.dup
      end
    end # class
  end # module
end # module

