module Zenlish
  module Feature
    class FeatureValue
      attr_reader :val

      def initialize(aValue)
        @val = aValue
      end

      protected

      def valid_value()
        raise NotImplementedError
      end
    end # class
  end # module
end # module