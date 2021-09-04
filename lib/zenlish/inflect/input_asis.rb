# frozen_string_literal: true

require_relative 'atomic_o_expression'

module Zenlish
  module Inflect
    class InputAsIs < AtomicOExpression
      attr_reader :formal

      def initialize(anArgument)
        super()
        @formal = anArgument
      end

      def generate(headings, lexeme, actuals)
        if actuals.empty?
          hd = headings[formal.index]
          hd.evaluate_for(lexeme)
        else
          actuals[formal.index]
        end
      end
    end # class
  end # module
end # module
