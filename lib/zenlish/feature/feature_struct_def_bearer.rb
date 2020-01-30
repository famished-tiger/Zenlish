require_relative 'boolean_domain'
require_relative 'identifier_domain'
require_relative 'enumeration_domain'
require_relative 'feature_def'
require_relative 'feature_value'
require_relative 'feature_struct_def'

module Zenlish
  module Feature
    # Mix-in module. It adds a feature structure defintion to its host and
    # also factory methods to ease feature definition manipulation.
    module FeatureStructDefBearer
      # @param aParentStruct [Feature::FeatureStructDef] parent structure
      # @param aFeatureHash [Hash] hash with pairs of the form: String => FeatureDomain
      def init_struct_def(aParentStruct, aFeatureHash)
        @struct = FeatureStructDef.new(aParentStruct)
        aFeatureHash.each_pair do |name, domain|
          feature_def(name => domain)
        end
      end

      # @return [Feature::FeatureStructDef]
      def struct
        @struct
      end

      # Retrieve feature definition with given name.
      # @param aName [String] Name of feature def to search for.
      # @return [Feature::FeatureDef, NilClass]
      def [](aName)
        struct[aName]
      end

      # @return [Feature::BooleanDomain]      
      def boolean
        BooleanDomain.instance
      end

      # @return [Feature::EnumerationDomain] 
      def enumeration(*items)
        EnumerationDomain.new(*items)
      end
      
      def identifier(aDefaultValue = nil)
        IdentifierDomain.instance
      end

      # @param aPair [Hash] hash with one pair { String => FeatureDomain }
      def feature_def(aPair)
        if aPair.values[0].is_a?(Array)
          dom, val = aPair.values[0]
          val = dom.build_value(val) unless val.kind_of?(FeatureValue)
          featr_def = FeatureDef.new(aPair.keys[0], dom, val)
        else
          featr_def = FeatureDef.new(aPair.keys[0], aPair.values[0])
        end
        @struct.add_feature_def(featr_def)
      end

      def feature_def_dsl(&aBlock)
        instance_eval(&aBlock)
      end
    end # module
  end # module
end # module
