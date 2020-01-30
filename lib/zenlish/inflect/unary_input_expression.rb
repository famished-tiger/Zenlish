require_relative 'input_expression'

module Zenlish
  module Inflect
    class UnaryInputExpression < InputExpression
      attr_reader :argument
      
      def initialize(anArgument)
        @argument = anArgument
      end
    end # class
  end # module
end # module
