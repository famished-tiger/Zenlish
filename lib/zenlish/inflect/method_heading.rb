require_relative 'heading'

module Zenlish
  module Inflect
    class MethodHeading < Heading

      def initialize(aLabel)
        super(aLabel)
      end
      
      def evaluate_for(aFeatureBearer)
        aFeatureBearer.send(label)
      end      
    end # class
  end # module
end # module
