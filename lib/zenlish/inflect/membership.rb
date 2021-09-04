# frozen_string_literal: true

require_relative 'unary_input_expression'

module Zenlish
  module Inflect
    class Membership < UnaryInputExpression
      attr_reader :members

      def initialize(anArgument, theMembers)
        super(anArgument)
        @members = theMembers
      end

      def success?(headings, lexeme, actuals)
        if actuals.empty?
          hd = headings[argument.index]
          feat_def = hd.evaluate_for(lexeme)
          members.all? { |memb| feat_def.domain.include?(memb) }
        else
          val = actuals[argument.index]
          members.include?(val)
        end
      end
    end # class
  end # module
end # module
