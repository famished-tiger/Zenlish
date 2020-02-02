require_relative 'unary_input_expression'

module Zenlish
  module Inflect
    class NotEqualsLiteral < UnaryInputExpression
      attr_reader :literal

      def initialize(anArgument, aLiteral)
        super(anArgument)
        @literal = aLiteral
      end

      def success?(headings, lexeme, actuals)
        if actuals.empty?
          hd = headings[argument.index]
          feat_def = hd.evaluate_for(lexeme)
          !feat_def.domain.include?(literal)
        else
          val = actuals[argument.index]
          val != literal
        end
      end
    end # class
  end # module
end # module
