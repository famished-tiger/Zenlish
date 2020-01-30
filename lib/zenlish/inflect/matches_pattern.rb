require_relative 'unary_input_expression'

module Zenlish
  module Inflect
    class MatchesPattern < UnaryInputExpression
      attr_reader :pattern

      def initialize(anArgument, aPattern)
        super(anArgument)
        @pattern = aPattern
      end

      def success?(headings, lexeme, actuals)
        val = nil
        if actuals.empty?
          # require 'debug'
          hd = headings[argument.index]
          val = hd.evaluate_for(lexeme)
        else
          val = actuals[argument.index]
        end
        val =~ pattern
      end
    end # class
  end # module
end # module
