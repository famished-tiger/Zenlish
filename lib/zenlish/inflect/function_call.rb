require_relative 'atomic_o_expression'

module Zenlish
  module Inflect
    class FunctionCall < AtomicOExpression
      attr_reader :mth_name

      def initialize(aMethodName)
        @mth_name = aMethodName
      end

      def generate(_headings, lexeme, _values)
        lexeme.send(mth_name)
      end
    end # class
  end # module
end # module