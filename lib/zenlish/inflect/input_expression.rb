# frozen_string_literal: true

module Zenlish
  module Inflect
    class InputExpression
      def success?(_lexeme, _heading_values)
        raise NotImplementedError, 'Method must be implemented in subclass(es).'
      end
    end # class
  end # module
end # module
