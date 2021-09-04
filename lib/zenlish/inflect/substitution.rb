# frozen_string_literal: true

require_relative 'literal_asis'
require_relative 'composite_o_expression'

module Zenlish
  module Inflect
    class Substitution < CompositeOExpression
      def initialize(theOriginal, aPattern, theReplacement)
        valid_original = validated_argument(theOriginal)
        valid_pattern = validated_pattern(aPattern)
        valid_replac = validated_argument(theReplacement)
        super([valid_original, valid_pattern, valid_replac])
      end

      def generate(headings, lexeme, values)
        original = children[0].generate(headings, lexeme, values)
        replacement = children[-1].generate(headings, lexeme, values)

        original.sub(pattern, replacement)
      end

      def pattern
        children[1]
      end

      private

      def validated_original(theOriginal)
        arg = nil
        if theOriginal.kind_of?(String)
          arg = LiteralAsIs.new(theOriginal)
        elsif theOriginal.kind_of?(OutputExpression)
          arg = theOriginal
        else
          err_msg = "Expected an OutputExpression, found '#{theOriginal.inspect}' instead."
          raise StandardError, err_msg
        end

        arg
      end

      def validated_pattern(aPattern)
        unless aPattern.kind_of?(Regexp)
          err_msg = "Expected a Regexp, found #{aPattern.inspect}."
          raise StandardError, err_msg
        end

        aPattern
      end

      def validated_argument(anArgument)
        arg = nil
        if anArgument.kind_of?(String)
          arg = LiteralAsIs.new(anArgument)
        elsif anArgument.kind_of?(OutputExpression)
          arg = anArgument
        else
          err_msg = "Expected an OutputExpression, found #{anArgument.inspect}."
          raise StandardError, err_msg
        end

        arg
      end
    end # class
  end # module
end # module
