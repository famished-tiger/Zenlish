# frozen_string_literal: true

require_relative 'nullary_input_expression'

module Zenlish
  module Inflect
    class UnconditionallyTrue < NullaryInputExpression
      def success?(_headings, _lexeme, _heading_values)
        true
      end
    end # class
  end # module
end # module
