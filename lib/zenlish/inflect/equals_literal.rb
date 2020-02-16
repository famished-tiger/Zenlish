require_relative 'unary_input_expression'

module Zenlish
  module Inflect
    class EqualsLiteral < UnaryInputExpression
      attr_reader :literal

      def initialize(anArgument, aLiteral)
        super(anArgument)
        @literal = aLiteral
      end

      def success?(headings, lexeme, actuals)
        if actuals.empty?
          hd = headings[argument.index]
          feat_def = hd.evaluate_for(lexeme)
          feat_def.domain.include?(literal)
        else  
          val = actuals[argument.index]
          if val.kind_of?(Feature::FeatureDef)
            val.domain.include?(literal)
          else
            val == literal
          end
        end
      end
    end # class
  end # module
end # module
