require_relative 'heading'

module Zenlish
  module Inflect
    class FeatureHeading < Heading

      def initialize(aLabel)
        super(aLabel)
      end
      
      def evaluate_for(aFeatureBearer)
        aFeatureBearer[label]
      end
    end # class
  end # module
end # module
