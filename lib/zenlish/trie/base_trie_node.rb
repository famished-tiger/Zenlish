# frozen_string_literal: true

module Zenlish
  module Trie
    # Abstract class for representing nodes in the trie data structure.
    class BaseTrieNode
      # @return [Hash{String => TrieNode}] the successor nodes
      attr_reader :succ

      def initialize
        @succ = {}
      end

      def include?(aKey)
        succ.include?(aKey)
      end

      def add_succ(aKey, aNode)
        succ[aKey] = aNode
      end

      def leaf?
        succ.empty?
      end
    end # class
  end # module
end # module
