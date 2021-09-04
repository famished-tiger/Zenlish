# frozen_string_literal: true

require_relative 'input_expression'

module Zenlish
  module Inflect
    class UnaryInputExpression < InputExpression
      attr_reader :argument

      def initialize(anArgument)
        super()
        @argument = anArgument
      end
    end # class
  end # module
end # module
