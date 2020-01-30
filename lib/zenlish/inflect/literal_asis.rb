require_relative 'atomic_o_expression'

module Zenlish
  module Inflect
    class LiteralAsIs < AtomicOExpression
      attr_reader :text

      def initialize(aLiteralValue)
        @text = aLiteralValue
      end

      def generate(_headings, _lexeme, _values)
        text
      end
    end # class
  end # module
end # module