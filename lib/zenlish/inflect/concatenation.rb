# frozen_string_literal: true

require_relative 'literal_asis'
require_relative 'composite_o_expression'

module Zenlish
  module Inflect
    class Concatenation < CompositeOExpression
      def initialize(argument1, argument2)
        super([validated_argument(argument1), validated_argument(argument2)])
      end

      def generate(headings, lexeme, values)
        part1 = children[0].generate(headings, lexeme, values)
        part2 = children[-1].generate(headings, lexeme, values)

        part1 + part2
      end

      private

      def validated_argument(anArgument)
        arg = nil
        if anArgument.kind_of?(String)
          arg = LiteralAsIs.new(anArgument)
        elsif anArgument.kind_of?(OutputExpression)
          arg = anArgument
        else
          err_msg = "Unexpected type of argument #{anArgument.inspect}."
          raise StandardError, err_msg
        end

        arg
      end
    end # class
  end # module
end # module
