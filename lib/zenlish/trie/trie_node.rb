# frozen_string_literal: true

require_relative 'base_trie_node'

module Zenlish
  module Trie
    class TrieNode < BaseTrieNode
      # @return [String] the matching character
      attr_reader :key

      # @return [Object, NilClass] Result when this character matches end-of-word.
      attr_accessor :value

      def initialize(aChar)
        super()
        @key = aChar
        @value = nil
      end
    end # class
  end # module
end # module
