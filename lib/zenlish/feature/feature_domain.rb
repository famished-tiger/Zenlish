module Zenlish
  module Feature
    class FeatureDomain
      def include?(aValue)
        raise NotImplementedError, "Implement #{__callee__} method in subclass(es)."
      end

      def to_a
        raise NotImplementedError, "Implement #{__callee__} method in subclass(es)."
      end
    end # class
  end # module
end # module