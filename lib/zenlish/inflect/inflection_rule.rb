# frozen_string_literal: true

module Zenlish
  module Inflect
    # An inflection rule has two-parts:
    # - a set of input conditions
    # - a consequent part which tells how to inflect a lexeme
    class InflectionRule
      attr_reader :conditions
      attr_reader :consequent

      def initialize(theConditions, aConsequentExpr)
        @conditions = theConditions
        @consequent = aConsequentExpr
      end

      def success?(theHeadings, aLexeme, actuals)
        conditions.all? { |cond| cond.success?(theHeadings, aLexeme, actuals) }
      end

      def apply(theHeadings, aLexeme, actuals)
        consequent.generate(theHeadings, aLexeme, actuals)
      end

      def force_apply(theHeadings, aLexeme)
        consequent.generate(theHeadings, aLexeme)
      end
    end # class
  end # module
end # module
