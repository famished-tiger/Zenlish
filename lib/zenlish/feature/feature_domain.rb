module Zenlish
  module Feature
    class FeatureDomain
      def include?(aValue)
        raise NotImplementedError, 'Implemented this method in subclass(es).'
      end
    end # class
  end # module
end # module